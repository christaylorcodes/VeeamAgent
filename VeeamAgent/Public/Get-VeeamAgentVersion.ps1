function Get-VeeamAgentVersion {
    if(Get-Service VeeamEndpointBackupSvc -ErrorAction SilentlyContinue){
        (Get-ItemProperty "HKLM:\SOFTWARE\Veeam\Veeam Agent for Microsoft Windows" -Name Version).Version
    }
    else{
        Write-Verbose 'Veeam Agent install not found.'
        $False
    }
}