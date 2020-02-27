function Get-VeeamAgentForeignRepositoryProvider {
    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC dbo.[GetAllForeignRepositoryProviders];'
    Invoke-VeeamAgentDBQuery -Query $Query
}