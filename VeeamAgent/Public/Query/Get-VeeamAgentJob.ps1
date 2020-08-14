function Get-VeeamAgentJob {
    [CmdletBinding()]
    param ()

    New-VeeamAgentDatabaseConnection
    $Query = 'EXEC "dbo"."GetJobsAll";'
    Invoke-VeeamAgentDBQuery -Query $Query
}