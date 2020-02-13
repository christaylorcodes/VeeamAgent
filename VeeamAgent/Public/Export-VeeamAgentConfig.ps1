function Export-VeeamAgentConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Path,
        [guid]$ID
    )
    $Option = @()
    if ($ID) {$Option += "/id:$ID"}
    $Option += "/f:`"$Path`""
    $Command = "`"$env:ProgramFiles\Veeam\Endpoint Backup\Veeam.Agent.Configurator.exe`" -export $($Option -join ' ')"
    Write-Verbose $Command
    cmd /c $Command
}