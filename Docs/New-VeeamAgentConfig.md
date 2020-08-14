---
external help file: VeeamAgent-help.xml
Module Name: VeeamAgent
online version:
schema: 2.0.0
---

# New-VeeamAgentConfig

## SYNOPSIS
Will configure generate a Veeam Agent for Windows configuration file.

## SYNTAX

### Network
```
New-VeeamAgentConfig -NetworkPath <Uri> [-Credential <PSCredential>] [-ConfigPath <String>]
 [-EncryptionKey <String>] [-EncryptionHint <String>] [-RestorePoints <Int32>] [-Brand <String>]
 [-JobName <String>] [-JobDesc <String>] [-HealthChecks] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Cloud
```
New-VeeamAgentConfig -Credential <PSCredential> -ServerName <String> -RemoteRepositoryName <String>
 [-ServerPort <Int32>] [-ConfigPath <String>] [-EncryptionKey <String>] [-EncryptionHint <String>]
 [-RestorePoints <Int32>] [-Brand <String>] [-JobName <String>] [-JobDesc <String>] [-HealthChecks] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Local
```
New-VeeamAgentConfig [-LocalBackupDestination <FileInfo>] [-ConfigPath <String>] [-EncryptionKey <String>]
 [-EncryptionHint <String>] [-RestorePoints <Int32>] [-Brand <String>] [-JobName <String>] [-JobDesc <String>]
 [-HealthChecks] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Allows the creation of a Veeam Agent for Windows configuration file with defined parameters.
Local and Network options available.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-VeeamAgentConfig -Type Local -EncryptionPassword SuperSecret! -Restorepoints 99
```

This will configure a machine to backup its C drive to the largest secondary drive the machine has. It will encrypt the backups with the supplied password and keep 99 restore points.

## PARAMETERS

### -ConfigPath
Path to save the xml config.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NetworkPath
The UNC path for network backups. Example, \\Server\Share

```yaml
Type: Uri
Parameter Sets: Network
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestorePoints
The amount of restore points to configure the job with.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Brand
{{ Fill Brand Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
{{ Fill Credential Description }}

```yaml
Type: PSCredential
Parameter Sets: Network
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: PSCredential
Parameter Sets: Cloud
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EncryptionHint
{{ Fill EncryptionHint Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EncryptionKey
{{ Fill EncryptionKey Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HealthChecks
{{ Fill HealthChecks Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -JobDesc
{{ Fill JobDesc Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -JobName
{{ Fill JobName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LocalBackupDestination
{{ Fill LocalBackupDestination Description }}

```yaml
Type: FileInfo
Parameter Sets: Local
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoteRepositoryName
{{ Fill RemoteRepositoryName Description }}

```yaml
Type: String
Parameter Sets: Cloud
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServerName
{{ Fill ServerName Description }}

```yaml
Type: String
Parameter Sets: Cloud
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServerPort
{{ Fill ServerPort Description }}

```yaml
Type: Int32
Parameter Sets: Cloud
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES
Author: Chris Taylor

## RELATED LINKS

[https://christaylor.codes](christaylor.codes)
