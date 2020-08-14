function Install-VeeamAgent {
    [CmdletBinding()]
    Param(
        [string]$DownloadPath = $env:TEMP,
        [string]$DownloadURL = $DefaultDownloadURL,
        [string]$MD5 = $DefaultMD5,
        [switch]$Force,
        [switch]$Upgrade
    )
    $DownloadFileName = 'VeeamAgent.zip'
    $Installer = (Split-Path $DownloadURL -Leaf).Replace('.zip','.exe')
    $InstallerPath = (Join-Path $DownloadPath $Installer).Replace('.exe','.exe')
    [version]$InstallerVersion = ($Installer -split '_')[1] -replace '.exe', ''

    # Test to see if Veeam Agent is already installed
    $CurrentVersion = Get-VeeamAgentVersion
    if($CurrentVersion -ne $False `
    -and !$Force.IsPresent `
    -and (
        ($Upgrade.IsPresent -and $InstallerVersion -le [version]$CurrentVersion) `
        -or !$Upgrade.IsPresent)
    ){ return Write-Output "Veeam Agent For Windows $CurrentVersion, is already installed." }

    # admin check
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if(!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        return Write-Error 'Access denied, run as admin.'
    }

    # Test to see if there is already an installer present and a force has not been issued.
    if((Test-Path $InstallerPath) -eq $False -or (Get-FileHash $InstallerPath -Algorithm MD5).Hash -ne $MD5 -or $Force){

        Write-Verbose "Downloading installer."
        try{
            if(!(Test-Path $DownloadPath)){
                New-Item -ItemType Directory $DownloadPath
            }
            Remove-Item "$DownloadPath\$DownloadFileName" -Force -ErrorAction SilentlyContinue | Out-Null
            Invoke-WebRequest -Uri $DownloadURL -OutFile "$DownloadPath\$DownloadFileName"
        }
        catch{
            Write-Error "There was an error downloading the agent." -ErrorAction Continue
            Write-Error $_ -ErrorAction Stop
        }

        Write-Verbose "Extracting installer"
        try{
            Remove-Item $InstallerPath -Force -ErrorAction SilentlyContinue | Out-Null
            Add-Type -AssemblyName System.IO.Compression.FileSystem
            [System.IO.Compression.ZipFile]::ExtractToDirectory("$DownloadPath\$DownloadFileName", $DownloadPath)
        }
        catch{
            $Message = "There was an error extracting the agent."
            $Message += $_
            return Write-Error  $Message
        }
    }

    Write-Verbose "Installing agent"
    try{
        $ArgumentList = @('/silent', '/accepteula', '/acceptthirdpartylicenses')
        $InstallProcess = Start-Process $InstallerPath -ArgumentList $ArgumentList -PassThru
        $InstallProcess.WaitForExit()
        if($InstallProcess.ExitCode -eq 1000){
            Write-Verbose "Veeam Agent for Microsoft Windows has been successfully installed."
        }
        elseif($InstallProcess.ExitCode -eq 1001){
            return Write-Output "Prerequisite components required for Veeam Agent for Microsoft Windows have been installed on the machine. Veeam Agent for Microsoft Windows has not been installed. The machine needs to be rebooted."
        }
        elseif($InstallProcess.ExitCode -eq 1002){
            return Write-Error "Veeam Agent for Microsoft Windows installation has failed. ExitCode 1002"
        }
        elseif($InstallProcess.ExitCode -eq 1101){
            Write-Output "Veeam Agent for Microsoft Windows has been installed. The machine needs to be rebooted."
        }
        else{
            return Write-Error "There was an unknown exit code, $($InstallProcess.ExitCode)"
        }
    }
    catch{
        return Write-Error $_
    }
    Write-Verbose "Cleaning up"
    $null = Remove-Item "$DownloadPath\$DownloadFileName" -Force
    $null = Remove-Item $InstallerPath -Force
}