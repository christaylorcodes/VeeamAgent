---
external help file: VeeamAgent-help.xml
Module Name: VeeamAgent
online version:
schema: 2.0.0
---

# Invoke-VeeamAgentBackup

## SYNOPSIS
Initiate a backup.

## SYNTAX

### Standalone
```
Invoke-VeeamAgentBackup [-ID <Guid>] [-Path <String>] [-Standalone] [<CommonParameters>]
```

### Backup
```
Invoke-VeeamAgentBackup [-ID <Guid>] [-Backup] [<CommonParameters>]
```

### ActiveFull
```
Invoke-VeeamAgentBackup [-ID <Guid>] [-ActiveFull] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ActiveFull
{{ Fill ActiveFull Description }}

```yaml
Type: SwitchParameter
Parameter Sets: ActiveFull
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Backup
{{ Fill Backup Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Backup
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
{{ Fill ID Description }}

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
{{ Fill Path Description }}

```yaml
Type: String
Parameter Sets: Standalone
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Standalone
{{ Fill Standalone Description }}

```yaml
Type: SwitchParameter
Parameter Sets: Standalone
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

## RELATED LINKS
