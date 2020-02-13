function Remove-VeeamAgentLicense {
    [CmdletBinding()]
    param ()
    Remove-Item 'HKLM:\SOFTWARE\Veeam\Veeam Agent for Microsoft Windows\license\Lic1'
    Remove-Item 'HKLM:\SOFTWARE\Veeam\Veeam Agent for Microsoft Windows\license\LicenseMode'
}