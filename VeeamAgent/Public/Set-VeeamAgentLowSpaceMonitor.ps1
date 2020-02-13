function Set-VeeamAgentLowSpaceMonitor {
    param(
        $GBLimit = 100GB,
        $PercentLimit = 10
    )

    $Query = @'
SELECT
	(((dbo.BackupRepositories.total_space) / 1024) /1024 / 1024) as 'RepositorySize'
FROM dbo.BJobs
JOIN dbo.BackupRepositories
ON (dbo.BackupRepositories.id = dbo.BJobs.repository_id)
JOIN dbo.ObjectsInJobs
ON (dbo.ObjectsInJobs.job_id = dbo.BJobs.id)
WHERE dbo.BJobs.type = 4000
'@
    $Repository = Invoke-VeeamAgentDBQuery -Query $Query
    $Total = "$($Repository.RepositorySize)GB"
    [int]$Percent = $GBLimit / $Total * 100
    [int]$CurrentSetting = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Veeam\Veeam Endpoint Backup').BackupRepositoryFreeSpaceThresholdPercent

    if ($Percent -lt $PercentLimit -and $Percent -ne $CurrentSetting){
        Write-Output "Adjusting low space threshold to $($Percent)%"
        New-ItemProperty -Path 'HKLM:\SOFTWARE\Veeam\Veeam Endpoint Backup' -Name 'BackupRepositoryFreeSpaceThresholdPercent' -PropertyType DWORD -Value $Percent -Force | Out-Null
        break
    }
    if ($CurrentSetting -eq $PercentLimit){ return }
    if ($Percent -gt $PercentLimit) {
            Write-Output "Adjusting low space threshold to limit $($PercentLimit)%"
            New-ItemProperty -Path 'HKLM:\SOFTWARE\Veeam\Veeam Endpoint Backup' -Name 'BackupRepositoryFreeSpaceThresholdPercent' -PropertyType DWORD -Value $PercentLimit -Force | Out-Null
    } else {
        Write-Output "Current threshold is correct."
    }
}
