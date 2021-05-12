function New-VeeamAgentConfig {
    [CmdletBinding(SupportsShouldProcess)]
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,ParameterSetName='Network')]
        [uri]$NetworkPath,
        [Parameter(Mandatory=$True,ParameterSetName='Cloud')]
        [Parameter(ParameterSetName='Network')]
        [pscredential]$Credential,
        [Parameter(Mandatory=$True,ParameterSetName='Cloud')]
        [string]$ServerName,
        [Parameter(Mandatory=$True,ParameterSetName='Cloud')]
        [string]$RemoteRepositoryName,
        [Parameter(ParameterSetName='Cloud')]
        [int]$ServerPort = 6180,
        [Parameter(ParameterSetName='Local')]
        [System.IO.FileInfo]$LocalBackupDestination,
        [string]$ConfigPath = $(Join-Path $env:TEMP VeeamConfig.xml),
        [string]$EncryptionKey,
        [string]$EncryptionHint,
        [int]$RestorePoints = 14,
        [string]$Brand = 'Veeam Agent',
        [string]$JobName,
        [string]$JobDesc = "Created by $env:USERNAME at $(Get-Date), using the VeeamAgent PowerShell module.",
        [switch]$HealthChecks,
        [ValidateScript({
            if( -Not ($_ | Test-Path) ){
                throw "Existing config does not exist"
            }
            return $true
        })]
        [System.IO.FileInfo]$AppendToExisting
    )
    Begin{
        $Invocation = (Get-Variable MyInvocation -Scope 1).Value
        $ConfigRoot = "$(Split-Path $Invocation.MyCommand.Path)\Private\Configuration Templates\"
    }

    Process{
        Try{
            if ($PSCmdlet.ParameterSetName -eq 'Network') {
                $Type = 'Network'
                # TODO
                if (![bool]$NetworkPath.IsUnc) {
                    return Write-Output "ERROR: Network Path given is not a UNC path. '\\Server\Share'"
                }
                [xml]$xml = Get-Content "$($ConfigRoot)\Network.xml"
                $xml.ExecutionResult.data.JobInfo.TargetInfo.Path = $NetworkPath.LocalPath
                if (!$Credential) {
                    $null = $xml.ExecutionResult.data.JobInfo.TargetInfo.CredentialsInfo.RemoveAll()
                } else {
                    $xml.ExecutionResult.data.JobInfo.TargetInfo.CredentialsInfo.UserName = ConvertTo-VeeamEncodedString $Credential.UserName
                    $xml.ExecutionResult.data.JobInfo.TargetInfo.CredentialsInfo.Password = ConvertTo-VeeamEncodedString $Credential.GetNetworkCredential().Password
                }
            }
            if($PSCmdlet.ParameterSetName -eq 'Local') {
                $Type = 'Local'
                $DriveName = $LocalBackupDestination.FullName[0..2] -join ''
                $RelativePath = "$($LocalBackupDestination.FullName.replace($DriveName, ''))\"
                [xml]$xml = Get-Content "$($ConfigRoot)\Local.xml"
                $xml.ExecutionResult.data.JobInfo.TargetInfo.DriveName = $DriveName
                $xml.ExecutionResult.data.JobInfo.TargetInfo.RelativePath = $RelativePath
            }
            if($PSCmdlet.ParameterSetName -eq 'Cloud') {
                $Type = 'Cloud'
                [xml]$xml = Get-Content "$($ConfigRoot)\CloudConnect.xml"

                # Cloud config
                $xml.ExecutionResult.Data.JobInfo.TargetInfo.ServerName = $ServerName
                $xml.ExecutionResult.Data.JobInfo.TargetInfo.ServerPort = $ServerPort.ToString()
                $xml.ExecutionResult.Data.JobInfo.TargetInfo.RemoteRepositoryName = $RemoteRepositoryName
                $xml.ExecutionResult.Data.JobInfo.TargetInfo.GateList = "$($ServerName):$($ServerPort)"
                $xml.ExecutionResult.Data.JobInfo.TargetInfo.ServerCredentials.UserName = ConvertTo-VeeamEncodedString $Credential.UserName
                $xml.ExecutionResult.Data.JobInfo.TargetInfo.ServerCredentials.Password = ConvertTo-VeeamEncodedString $Credential.GetNetworkCredential().Password
            }

            $xml.ExecutionResult.Version = "$(Get-VeeamAgentVersion)"
            $xml.ExecutionResult.Data.JobInfo.ObjectName = $env:COMPUTERNAME
            if (-not $JobName) { $JobName = "$Type Backup Job $env:COMPUTERNAME"}
            $xml.ExecutionResult.Data.JobInfo.JobName = $JobName
            $xml.ExecutionResult.Data.JobInfo.JobDesc = $JobDesc
            if ($EncryptionKey) {
                $xml.ExecutionResult.Data.JobInfo.StorageInfo.Encryption.Key.Hint = ConvertTo-VeeamEncodedString $EncryptionHint
                $xml.ExecutionResult.Data.JobInfo.StorageInfo.Encryption.Key.Password = ConvertTo-VeeamEncodedString $EncryptionKey
            } else {
                $xml.ExecutionResult.Data.JobInfo.StorageInfo.Encryption.Enabled = 'False'
                $null = $xml.ExecutionResult.Data.JobInfo.StorageInfo.Encryption.Key.RemoveAll()
            }
            if ($HealthChecks) {
                $xml.ExecutionResult.Data.JobInfo.ScheduleInfo.HealthCheck.MonthlyInfo.Week = $(Get-Random -Minimum 1 -Maximum 4).ToString()
                $xml.ExecutionResult.Data.JobInfo.ScheduleInfo.HealthCheck.MonthlyInfo.DayOfWeek = $(Get-Random -Minimum 1 -Maximum 7).ToString()
            } else {
                $ChildNode = $xml.ExecutionResult.Data.JobInfo.ScheduleInfo.SelectSingleNode('HealthCheck')
                $null = $xml.ExecutionResult.Data.JobInfo.ScheduleInfo.RemoveChild($ChildNode)
            }
            $xml.ExecutionResult.Data.JobInfo.RetentionInfo.RestorePointsCount = $RestorePoints.ToString()
            $xml.ExecutionResult.Data.ApplicationSettings.LogoText = $Brand

            if ($AppendToExisting -and (Test-Path $AppendToExisting)) {
                $xml2 = $xml
                [xml]$xml = Get-Content $AppendToExisting
                $ImportTo = $Xml.SelectSingleNode("/ExecutionResult/Data")
                $ImportFrom = $Xml2.SelectSingleNode("/ExecutionResult/Data/JobInfo")
                if($xml.ExecutionResult.Data.JobInfo.JobName -contains $xml2.ExecutionResult.Data.JobInfo.JobName) {
                    return Write-Error 'JobName already exists'
                }
                $null = $ImportTo.AppendChild($XML.ImportNode($ImportFrom, $true))
            }

            if ($PSCmdlet.ShouldProcess($ConfigPath, "New-VeeamAgentConfig")) {
                $xml.Save($ConfigPath)
            }
        }

        Catch{
            $ErrorMessage = "There was an error building the config."
            $ErrorMessage += $_
            return Write-Error $ErrorMessage
        }
    }

    End{
        If($?){
            Write-Output "Configuration file created: $ConfigPath"
        }
    }
}