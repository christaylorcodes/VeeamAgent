function Get-VeeamAgentBackup {
    [CmdletBinding()]
    param ()

    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC dbo.[Backup.Model.GetBackupsAll];'
    Invoke-VeeamAgentDBQuery -Query $Query
}