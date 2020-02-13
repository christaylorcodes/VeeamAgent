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

```
New-VeeamAgentConfig [-Type] <String> [-ConfigPath <String>] [-EncryptionSecret <String>]
 [-RestorePoints <Int32>] [-NetworkPath <Uri>] [<CommonParameters>]
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
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Allows you to select Local or Network backup destination. Local backup will automatically select any USB drive with a back folder on the root or the largest drive.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Local, Network

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EncryptionSecret
{{ Fill EncryptionSecret Description }}

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
