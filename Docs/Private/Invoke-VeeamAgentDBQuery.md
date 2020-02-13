---
external help file:
Module Name:
online version:
schema: 2.0.0
---

# Invoke-VeeamAgentDBQuery

## SYNOPSIS
This is used to query the Veeam Agent database.

## SYNTAX

```
Invoke-VeeamAgentDBQuery [-Query] <String> [<CommonParameters>]
```

## DESCRIPTION
This scripts connects to the database executes the query and returns the object.

## EXAMPLES

### Example 1
```powershell
PS C:\> Invoke-VeeamAgentDBQuery -Query 'EXEC dbo.[Backup.Model.GetBackupsAll];'
```

This will execute a stored procedure.

## PARAMETERS

### -Query
A query to run against the MSSQL database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

[https://christaylor.codes](https://christaylor.codes)