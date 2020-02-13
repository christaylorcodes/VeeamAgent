function New-VeeamAgentDatabaseConnection {
    [CmdletBinding()]
    param(
        [switch]$Force
    )
    if ($script:VeeamAgentSQLParam -and !$Force) { return }
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if(!$currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Error 'Commands only work in elevated session, run as admin.'
        break;
    }
    if ((Get-VeeamAgentVersion) -eq $false) {
        Write-Error 'Veeam Agent install not found.'
        break;
    }
    # Get Veeam Endpoint database information
    $VeeamValues = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Veeam\Veeam Endpoint Backup\DbConfiguration'
    $VeeamDatabase = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Veeam\Veeam Endpoint Backup'

    # Configure database connection paramaters.
    $script:VeeamAgentSQLParam = @{
        dataSource = $VeeamValues.SqlInstancePipeName
        database = $VeeamDatabase.SqlDatabaseName
        username = $VeeamValues.SqlLogin
        password = $VeeamValues.SqlPassword
    }
}