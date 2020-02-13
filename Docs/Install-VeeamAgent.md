---
external help file: VeeamAgent-help.xml
Module Name: VeeamAgent
online version:
schema: 2.0.0
---

# Install-VeeamAgent

## SYNOPSIS
This function will install Veeam Agent For Windows.

## SYNTAX

```
Install-VeeamAgent [[-DownloadPath] <String>] [[-DownloadURL] <String>] [[-MD5] <String>] [-Force] [-Upgrade]
 [<CommonParameters>]
```

## DESCRIPTION
The script will download and extract the installer then install with all the defaults.

## EXAMPLES

### EXAMPLE 1
```
Install-VeeamAgentForWindows
```

## PARAMETERS

### -DownloadPath
{{ Fill DownloadPath Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $env:TEMP
Accept pipeline input: False
Accept wildcard characters: False
```

### -DownloadURL
URL to the VeeamAgent installer zip you want to install.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: https://download2.veeam.com/VeeamAgentWindows_3.0.2.1170_.zip
Accept pipeline input: False
Accept wildcard characters: False
```

### -MD5
MD5 of the installer to verify against.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 9724D5845D724A7903327142E7659125
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Used to force an install if another install is already found.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Upgrade
Will update an existing install if the installer is newer.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chris Taylor

## RELATED LINKS

[https://christaylor.codes](christaylor.codes)