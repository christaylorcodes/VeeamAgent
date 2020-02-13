function Install-VeeamAgentLicense {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Path,
        [Parameter(ParameterSetName = "Workstation")]
        [switch]$Workstation,
        [Parameter(ParameterSetName = "Server")]
        [switch]$Server
    )
    if ($Workstation) {$Option = ' /w'}
    if ($Server) {$Option = ' /s'}
    $Command = "`"$env:ProgramFiles\Veeam\Endpoint Backup\Veeam.Agent.Configurator.exe`" -license /f:`"$Path`"$Option"
    Write-Verbose $Command
    cmd /c $Command
}