function Get-VeeamAgentForeignRepositoryProvider {
    [CmdletBinding()]
    param ()

    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC dbo.[GetAllForeignRepositoryProviders];'
    Invoke-VeeamAgentDBQuery -Query $Query
}