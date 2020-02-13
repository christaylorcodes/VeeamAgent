function Get-VeeamAgentBackupRepository {
    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC dbo.GetAllBackupRepositories;'
    Invoke-VeeamAgentDBQuery -Query $Query
}