function Remove-VeeamAgent {
    [CmdletBinding(SupportsShouldProcess)]
    [CmdletBinding()]
    param (
        [switch]$DontRemoveLicense
    )
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if(!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        return Write-Error 'Access denied, run as admin.'
    }
    $Agents = Get-CimInstance -Classname WIn32_Product | Where-Object{$_.Name -like "Veeam Agent for *"}
    if ($Agents) {
        if ($PSCmdlet.ShouldProcess($Agents.IdentifyingNumber, "Remove-VeeamAgent")) {
            $uninstall = $Agents | Invoke-CimMethod -MethodName UnInstall
            if ($uninstall.ReturnValue -eq 0) {
                if(!$DontRemoveLicense.IsPresent) { Remove-VeeamAgentLicense }
            }
            elseif ($uninstall.ReturnValue -eq 1603) { Write-Error 'Access denied, run as admin.' }
            else { Write-Error $uninstall }
        }
    }
}