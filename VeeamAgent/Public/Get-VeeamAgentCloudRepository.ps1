function Get-VeeamAgentCloudRepository {
    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC dbo.GetAllCloudRepositories;'
    Invoke-VeeamAgentDBQuery -Query $Query
}