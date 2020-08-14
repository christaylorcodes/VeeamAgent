---
external help file: VeeamAgent-help.xml
Module Name: VeeamAgent
online version:
schema: 2.0.0
---

# Initialize-VeeamLocalBackupDestination

## SYNOPSIS
Will look for a local USB drive to use as a backup destination.

## SYNTAX

```
Initialize-VeeamLocalBackupDestination [<CommonParameters>]
```

## DESCRIPTION
Will look at all USB drives for an existing 'Backup*' folder. If no folder or multiple folders are found it will create a 'Backup' folder on the root of the largest drive.

## EXAMPLES

### Example 1
```powershell
PS C:\> Initialize-VeeamLocalBackupDestination
```

Will output a path to be used for backups.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
