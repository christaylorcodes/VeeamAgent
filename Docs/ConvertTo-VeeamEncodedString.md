---
external help file: VeeamAgent-help.xml
Module Name: VeeamAgent
online version:
schema: 2.0.0
---

# ConvertTo-VeeamEncodedString

## SYNOPSIS
Encodes strings for use in configurations.

## SYNTAX

```
ConvertTo-VeeamEncodedString [[-String] <String>] [<CommonParameters>]
```

## DESCRIPTION
The configurations require some strings to be encoded for them to be imported.

## EXAMPLES

### Example 1
```powershell
PS C:\> ConvertTo-VeeamEncodedString 'MyPlainTextPassword'
```

Will return an encoded string you can use in a Veeam Agent configuration file.

## PARAMETERS

### -String
The string you want encoded.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

### System.String
## NOTES

## RELATED LINKS
