function Get-VeeamAgentVersion {
    [OutputType([boolean],[version])]
    [CmdletBinding()]
    param ()

    if(Get-Service VeeamEndpointBackupSvc -ErrorAction SilentlyContinue){
        [version]$Version = (Get-ItemProperty "HKLM:\SOFTWARE\Veeam\Veeam Agent for Microsoft Windows" -Name Version).Version
        if (!$Version){ Write-Error 'Unable to determine version'}
        else { $Version }
    }
    else{
        Write-Verbose 'Veeam Agent install not found.'
        $False
    }
}