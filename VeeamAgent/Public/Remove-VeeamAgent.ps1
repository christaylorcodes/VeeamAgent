function Remove-VeeamAgent {
    [CmdletBinding()]
    param ()
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if(!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Error 'Access denied, run as admin.'
        break;
    }
    $Agents = Get-CimInstance -Classname WIn32_Product | Where-Object{$_.Name -like "Veeam Agent for *"}
    if ($Agents) {
        $uninstall = $Agents | Invoke-CimMethod -MethodName UnInstall
        if ($uninstall.ReturnValue -eq 0) {}
        elseif ($uninstall.ReturnValue -eq 1603) { Write-Error 'Access denied, run as admin.' }
        else { Write-Error $uninstall }
    }
}