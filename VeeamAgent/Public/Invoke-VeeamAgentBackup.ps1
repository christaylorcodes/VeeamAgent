function Invoke-VeeamAgentBackup {
    [CmdletBinding()]
    param (
        [guid]$ID,
        [Parameter(ParameterSetName = "Standalone")]
        [string]$Path,
        [Parameter(ParameterSetName = "Backup")]
        [switch]$Backup,
        [Parameter(ParameterSetName = "ActiveFull")]
        [switch]$ActiveFull,
        [Parameter(ParameterSetName = "Standalone")]
        [switch]$Standalone
    )
    $Arguments = @()
    if ($Backup) { $Arguments += '/backup' }
    if ($ActiveFull) { $Arguments += '/activefull' }
    if ($Standalone) { $Arguments += '/standalone' }
    if ($Path) { $Arguments += $Path }
    if ($ID) { $Arguments += "`"$ID`"" }
    $Command = "`"$env:ProgramFiles\Veeam\Endpoint Backup\Veeam.EndPoint.Manager.exe`" $($Arguments -join ' ')"
    Write-Verbose $Command
    cmd /c $Command
}