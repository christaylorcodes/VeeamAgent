function Install-VeeamAgent {
    [CmdletBinding()]
    Param(
        [string]$DownloadPath = $env:TEMP,
        [string]$DownloadURL = 'https://download2.veeam.com/VeeamAgentWindows_3.0.2.1170_.zip',
        [string]$MD5 = '9724D5845D724A7903327142E7659125',
        [switch]$Force,
        [switch]$Upgrade
    )
    $DownloadFileName = 'VeeamAgent.zip'
    $Installer = (Split-Path $DownloadURL -Leaf).Replace('.zip','.exe')
    $InstallerPath = (Join-Path $DownloadPath $Installer).Replace('_.exe','.exe')
    [version]$InstallerVersion = ($Installer -split '_')[1]

    # Test to see if Veeam Agent is already installed
    $CurrentVersion = Get-VeeamAgentVersion
    if($CurrentVersion -ne $False `
    -and !$Force.IsPresent `
    -and (
        ($Upgrade.IsPresent -and $InstallerVersion -le [version]$CurrentVersion) `
        -or !$Upgrade.IsPresent)
    ){
        Write-Output "Veeam Agent For Windows $CurrentVersion, is already installed."
        break
    }

    # admin check
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if(!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Error 'Access denied, run as admin.'
        break;
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
            Write-Output "There was an error downloading the agent."
            Write-Output $Error[0]
            break
        }

        Write-Verbose "Extracting installer"
        try{
            Remove-Item $InstallerPath -Force -ErrorAction SilentlyContinue | Out-Null
            Add-Type -AssemblyName System.IO.Compression.FileSystem
            [System.IO.Compression.ZipFile]::ExtractToDirectory("$DownloadPath\$DownloadFileName", $DownloadPath)
        }
        catch{
            Write-Output "There was an error extracting the agent."
            Write-Output $Error[0]
            break
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
            Write-Output "Prerequisite components required for Veeam Agent for Microsoft Windows have been installed on the machine. Veeam Agent for Microsoft Windows has not been installed. The machine needs to be rebooted."
            break
        }
        elseif($InstallProcess.ExitCode -eq 1002){
            Write-Output "Veeam Agent for Microsoft Windows installation has failed."
            break
        }
        elseif($InstallProcess.ExitCode -eq 1101){
            Write-Output "Veeam Agent for Microsoft Windows has been installed. The machine needs to be rebooted."
        }
        else{
            Write-Output "Error: There was an unknown exit code, $($InstallProcess.ExitCode)"
            break
        }
    }
    catch{
        Write-Error $_
        break
    }
    Write-Verbose "Cleaning up"
    $null = Remove-Item "$DownloadPath\$DownloadFileName" -Force
    $null = Remove-Item $InstallerPath -Force
}