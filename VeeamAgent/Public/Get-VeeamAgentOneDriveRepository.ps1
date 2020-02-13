function Get-VeeamAgentOneDriveRepository {
    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC dbo.GetAllOneDriveRepositories;'
    Invoke-VeeamAgentDBQuery -Query $Query
}