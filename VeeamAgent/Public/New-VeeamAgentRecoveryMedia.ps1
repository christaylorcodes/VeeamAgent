function New-VeeamAgentRecoveryMedia {
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = "Custom Path")]
        [string]$Path,
        [Parameter(ParameterSetName = "Custom Path")]
        [string]$FileName
    )
    if ($Path) { $CustomPath = " /f:$Path\$FileName.iso" }
    $Command = "`"$env:ProgramFiles\Veeam\Endpoint Backup\Veeam.EndPoint.Manager.exe`" /createrecoverymediaiso$CustomPath"
    Write-Verbose $Command
    cmd /c $Command
}