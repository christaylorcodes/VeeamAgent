function Get-VeeamAgentBackup {
    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC dbo.[Backup.Model.GetBackupsAll];'
    Invoke-VeeamAgentDBQuery -Query $Query
}