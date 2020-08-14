function Get-VeeamAgentBackupRepository {
    [CmdletBinding()]
    param ()

    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC dbo.GetAllBackupRepositories;'
    Invoke-VeeamAgentDBQuery -Query $Query
}