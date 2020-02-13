function Get-VeeamAgentBackupInJob {
    param(
        [Parameter(Mandatory = $True)]
        [GUID]$JobId
    )
    New-VeeamAgentDatabaseConnection
    $Query = "EXEC dbo.GetBackupsInJob @job_id = '$JobId'"
    Invoke-VeeamAgentDBQuery -Query $Query
}