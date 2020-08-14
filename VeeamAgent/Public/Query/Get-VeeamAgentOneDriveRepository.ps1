function Get-VeeamAgentOneDriveRepository {
    [CmdletBinding()]
    param ()

    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC dbo.GetAllOneDriveRepositories;'
    Invoke-VeeamAgentDBQuery -Query $Query
}