function New-VeeamAgentRecoveryMedia {
    [CmdletBinding(SupportsShouldProcess)]
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
    if ($PSCmdlet.ShouldProcess("$Path\$FileName.iso", "New-VeeamAgentRecoveryMedia")) {
        cmd /c $Command
    }
}