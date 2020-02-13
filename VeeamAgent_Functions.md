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
### [Export-VeeamAgentConfig](Export-VeeamAgentConfig.md)
Used to export jobs to a backup config.

### [Get-VeeamAgentBackup](Get-VeeamAgentBackup.md)
Lists all the backups configured on the agent.

### [Get-VeeamAgentBackupInJob](Get-VeeamAgentBackupInJob.md)
Gets the backups associated with a job ID.

### [Get-VeeamAgentBackupInRepository](Get-VeeamAgentBackupInRepository.md)
Gets the backups associated with a repository ID.

### [Get-VeeamAgentBackupRepository](Get-VeeamAgentBackupRepository.md)
Gets all the backup repositories that have been configured.

### [Get-VeeamAgentCloudRepository](Get-VeeamAgentCloudRepository.md)
Gets all the cloud repositories that have been configured.

### [Get-VeeamAgentJob](Get-VeeamAgentJob.md)
Lists all the agent jobs that have been configured.

### [Get-VeeamAgentJobHistory](Get-VeeamAgentJobHistory.md)
Gets the history for a job.

### [Get-VeeamAgentOneDriveRepository](Get-VeeamAgentOneDriveRepository.md)
Gets all the OneDrive repositories that have been configured.

### [Get-VeeamAgentRestorePoint](Get-VeeamAgentRestorePoint.md)
Lists agent restore points for a backup.

### [Get-VeeamAgentVersion](Get-VeeamAgentVersion.md)
Returns the currently installed Veeam Agent version. Returns $false if not found.

### [Import-VeeamAgentConfig](Import-VeeamAgentConfig.md)
Imports settings from an export.

### [Install-VeeamAgent](Install-VeeamAgent.md)
This function will install Veeam Agent For Windows.

### [Install-VeeamAgentLicense](Install-VeeamAgentLicense.md)
Will install a given license file.

### [Invoke-VeeamAgentBackup](Invoke-VeeamAgentBackup.md)
Initiate a backup.

### [New-VeeamAgentConfig](New-VeeamAgentConfig.md)
Will configure generate a Veeam Agent for Windows configuration file.

### [New-VeeamAgentRecoveryMedia](New-VeeamAgentRecoveryMedia.md)
Used to the create recovery media ISO.

### [Remove-VeeamAgent](Remove-VeeamAgent.md)
Uninstalls Veeam Agent

### [Remove-VeeamAgentLicense](Remove-VeeamAgentLicense.md)
Removes any and all licensing.

### [Set-VeeamAgentLowSpaceMonitor](Set-VeeamAgentLowSpaceMonitor.md)
Used to adjust low space alerts based on disk size.

