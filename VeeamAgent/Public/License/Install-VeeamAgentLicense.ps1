function Install-VeeamAgentLicense {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Path,
        [Parameter(Mandatory = $true, ParameterSetName = "Workstation")]
        [ValidateSet('Workstation', 'Server')]
        [string]$Type
    )
    switch ($Type) {
        'Workstation'   { $Option = ' /w' }
        'Server'        { $Option = ' /s' }
        default         { Throw 'Invalid type received.'}
     }
    $Command = "`"$env:ProgramFiles\Veeam\Endpoint Backup\Veeam.Agent.Configurator.exe`" -license /f:`"$Path`"$Option"
    Write-Verbose $Command
    $Result = cmd /c $Command
    if ($Result -ne 'ExitCode: 0') { Write-Error $Result }
}