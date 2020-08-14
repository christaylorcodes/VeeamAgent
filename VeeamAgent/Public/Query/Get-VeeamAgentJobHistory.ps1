function Get-VeeamAgentJobHistory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]
        [guid]$JobID
    )
    New-VeeamAgentDatabaseConnection
    $Query = "EXEC dbo.GetSessionsForJob @row_job_id = '$JobID';"
    Invoke-VeeamAgentDBQuery -Query $Query
}