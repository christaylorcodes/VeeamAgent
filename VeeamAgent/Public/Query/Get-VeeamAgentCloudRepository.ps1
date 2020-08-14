function Get-VeeamAgentCloudRepository {
    [CmdletBinding()]
    param ()

    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC dbo.GetAllCloudRepositories;'
    Invoke-VeeamAgentDBQuery -Query $Query
}