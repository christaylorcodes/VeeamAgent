function New-VeeamAgentDatabaseConnection {
    [CmdletBinding(SupportsShouldProcess)]
    [CmdletBinding()]
    param(
        [switch]$Force
    )
    if ($script:VeeamAgentSQLParam -and !$Force) {
        Write-Verbose 'Using cached connection information'
        return
    }
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if(!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        return Write-Error 'Commands only work in elevated session, run as admin.'
    }
    if ((Get-VeeamAgentVersion) -eq $false) {
        return Write-Error 'Veeam Agent install not found.'
    }
    # Get Veeam Endpoint database information
    $VeeamValues = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Veeam\Veeam Endpoint Backup\DbConfiguration'
    $VeeamDatabase = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Veeam\Veeam Endpoint Backup'

    if ($PSCmdlet.ShouldProcess("New-VeeamAgentDatabaseConnection")) {
        $script:VeeamAgentSQLParam = @{
            dataSource = $VeeamValues.SqlInstancePipeName
            database = $VeeamDatabase.SqlDatabaseName
            username = $VeeamValues.SqlLogin
            password = $VeeamValues.SqlPassword
        }
    }
}