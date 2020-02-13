function Get-VeeamAgentRestorePoint {
    param(
        [Parameter(Mandatory = $True)]
        [GUID]$BackupId
    )
    New-VeeamAgentDatabaseConnection
    $Query = "EXEC dbo.[Backup.Model.GetPointsInBackup] @backupId = '$BackupId';"
    Invoke-VeeamAgentDBQuery -Query $Query
}