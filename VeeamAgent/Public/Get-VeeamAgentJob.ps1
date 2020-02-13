function Get-VeeamAgentJob {
    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC "dbo"."GetJobsAll";'
    Invoke-VeeamAgentDBQuery -Query $Query
}