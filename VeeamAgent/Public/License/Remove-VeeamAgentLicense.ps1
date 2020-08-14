function Remove-VeeamAgentLicense {
    [CmdletBinding(SupportsShouldProcess)]
    [CmdletBinding()]
    param ()
    Remove-Item 'HKLM:\SOFTWARE\Veeam\Veeam Agent for Microsoft Windows\license'
}