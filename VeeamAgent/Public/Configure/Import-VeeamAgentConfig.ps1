function Import-VeeamAgentConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Path,
        [pscredential]$Credentials
    )
    if ($Credentials) {$Option = " /u:$($Credentials.UserName) /p:$($Credentials.GetNetworkCredential().Password)"}
    $Command = "`"$env:ProgramFiles\Veeam\Endpoint Backup\Veeam.Agent.Configurator.exe`" -import /f:`"$Path`"$Option"
    Write-Verbose $Command
    cmd /c $Command 2>&1
}