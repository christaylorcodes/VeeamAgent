function Get-VeeamAgentBackupInRepository {
    param(
        [Parameter(Mandatory = $True)]
        [GUID]$RepositoryId
    )
    New-VeeamAgentDatabaseConnection
    $Query = "EXEC dbo.[Backup.Model.GetBackupsInRepository] @repositoryId = '$RepositoryId';"
    Invoke-VeeamAgentDBQuery -Query $Query
}