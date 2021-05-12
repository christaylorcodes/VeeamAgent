---
Module Name: VeeamAgent
Module Guid: bbbe2a80-8c0b-4036-b45d-4ef3a4246d7c
Download Help Link: {{ Update Download Link }}
Help Version: 0.0.0.1
Locale: en-US
---

# VeeamAgent Module
## Description
This module give you commands to un/install, configure, report and monitor on Veeam Agent.

## VeeamAgent Cmdlets
### [ConvertTo-VeeamEncodedString](Docs/ConvertTo-VeeamEncodedString.md)
Encodes strings for use in configurations.

### [Export-VeeamAgentConfig](Docs/Export-VeeamAgentConfig.md)
Used to export jobs to a backup config.

### [Get-VeeamAgentBackup](Docs/Get-VeeamAgentBackup.md)
Lists all the backups configured on the agent.

### [Get-VeeamAgentBackupInJob](Docs/Get-VeeamAgentBackupInJob.md)
Gets the backups associated with a job ID.

### [Get-VeeamAgentBackupInRepository](Docs/Get-VeeamAgentBackupInRepository.md)
Gets the backups associated with a repository ID.

### [Get-VeeamAgentBackupRepository](Docs/Get-VeeamAgentBackupRepository.md)
Gets all the backup repositories that have been configured.

### [Get-VeeamAgentCloudRepository](Docs/Get-VeeamAgentCloudRepository.md)
Gets all the cloud repositories that have been configured.

### [Get-VeeamAgentForeignRepositoryProvider](Docs/Get-VeeamAgentForeignRepositoryProvider.md)
{{ Fill in the Synopsis }}

### [Get-VeeamAgentJob](Docs/Get-VeeamAgentJob.md)
Lists all the agent jobs that have been configured.

### [Get-VeeamAgentJobHistory](Docs/Get-VeeamAgentJobHistory.md)
Gets the history for a job.

### [Get-VeeamAgentOneDriveRepository](Docs/Get-VeeamAgentOneDriveRepository.md)
Gets all the OneDrive repositories that have been configured.

### [Get-VeeamAgentRestorePoint](Docs/Get-VeeamAgentRestorePoint.md)
Lists agent restore points for a backup.

### [Get-VeeamAgentVersion](Docs/Get-VeeamAgentVersion.md)
Returns the currently installed Veeam Agent version. Returns $false if not found.

### [Import-VeeamAgentConfig](Docs/Import-VeeamAgentConfig.md)
Imports settings from an export.

### [Initialize-VeeamLocalBackupDestination](Docs/Initialize-VeeamLocalBackupDestination.md)
Will look for a local USB drive to use as a backup destination.

### [Install-VeeamAgent](Docs/Install-VeeamAgent.md)
This function will install Veeam Agent For Windows.

### [Install-VeeamAgentLicense](Docs/Install-VeeamAgentLicense.md)
Will install a given license file.

### [Invoke-VeeamAgentBackup](Docs/Invoke-VeeamAgentBackup.md)
Initiate a backup.

### [New-VeeamAgentConfig](Docs/New-VeeamAgentConfig.md)
Will configure generate a Veeam Agent for Windows configuration file.

### [New-VeeamAgentRecoveryMedia](Docs/New-VeeamAgentRecoveryMedia.md)
Used to the create recovery media ISO.

### [Remove-VeeamAgent](Docs/Remove-VeeamAgent.md)
Uninstalls Veeam Agent

### [Remove-VeeamAgentLicense](Docs/Remove-VeeamAgentLicense.md)
Removes any and all licensing.

### [Set-VeeamAgentLowSpaceMonitor](Docs/Set-VeeamAgentLowSpaceMonitor.md)
Used to adjust low space alerts based on disk size.

