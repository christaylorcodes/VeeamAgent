function New-VeeamAgentConfig {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,Position=1)]
        [ValidateSet('Local','Network')]
        [String] $Type,
        [string]$ConfigPath = $(Join-Path $env:TEMP VeeamConfig.xml),
        [string]$EncryptionSecret,
        [int]$RestorePoints = 14,
        [uri]$NetworkPath
    )
    Begin{
        $Bytes = [System.Text.Encoding]::Unicode.GetBytes($EncryptionSecret)
        $EncodedEncryptionPassword =[Convert]::ToBase64String($Bytes)
    }

    Process{
        Try{
            if (![bool](([uri]$NetworkPath).IsUnc)) {
                # NEED PATH
                if (![bool]$NetworkPath.IsUnc) {
                    Write-Output "ERROR: Network Path given is not a UNC path. '\\Server\Share'"
                    Break
                }

                $NetworkConfig = 'PEV4ZWN1dGlvblJlc3VsdCBWZXJzaW9uPSIyLjAuMC43MDAiIEV4aXRDb2RlPSIwIj48RGF0YT48QXBwbGljYXRpb25TZXR0aW5ncyBDcnlwdFR5cGU9IjEwIiBDcnlwdElkPSIwMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDAiIENoZWNrVXBkYXRlcz0iRmFsc2UiIERpc2FibGVTY2hlZHVsZWRCYWNrdXBzPSJGYWxzZSIgRGlzYWJsZUNvbnRyb2xQYW5lbE5vdGlmaWNhdGlvbj0iRmFsc2UiIFRocm90dGxlQmFja3VwQWN0aXZpdHk9IlRydWUiIFNob3dCYWNrdXBEdXJhdGlvbj0iRmFsc2UiIERpc2FibGVCYWNrdXBPdmVyTWV0ZXJlZENvbm5lY3Rpb249IlRydWUiIExvY2tEb3duTW9kZT0iRmFsc2UiIFNlcnZpY2VQcm92aWRlck1vZGU9IkZhbHNlIiBMYXN0Q2hlY2tGb3JVcGRhdGVzPSIxMC8xMS8yMDE3IDA4OjQ0OjE2IiBMb2dvVGV4dD0iaS50LkJBQ0tVUCIgLz48Sm9iSW5mbyBDcnlwdFR5cGU9IjEwIiBDcnlwdElkPSIwMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDAiPjxTb3VyY2VJbmZvPjxFcERpc2tGaWx0ZXIgQmFja3VwTW9kZT0iMCIgQmFja3VwU3lzdGVtU3RhdGU9IkZhbHNlIiBCYWNrdXBVc2VyRm9sZGVycz0iRmFsc2UiPjxJbmNsdWRlTWFza3MgLz48RXhjbHVkZU1hc2tzIC8+PC9FcERpc2tGaWx0ZXI+PC9Tb3VyY2VJbmZvPjxUYXJnZXRJbmZvIFR5cGU9IjIiIFBhdGg9IlxcbG9jYWxob3N0XGJhY2t1cCI+PENyZWRlbnRpYWxzSW5mbyBVc2VyTmFtZT0iZEdWemRGeGpkR0Y1Ykc5eUxXRmtiV2x1IiBQYXNzd29yZD0iRW50ZXIgdGhlIHBhc3N3b3JkIGhlcmUiIC8+PC9UYXJnZXRJbmZvPjxTdG9yYWdlSW5mbyBDb21wcmVzc2lvbkxldmVsPSI1IiBCbG9ja1NpemU9IjEiPjxFbmNyeXB0aW9uIEVuYWJsZWQ9IlRydWUiPjxLZXkgSGludD0iYVM1MExrNVBWeUJ6ZEdGdVpHRnlaQT09IiBQYXNzd29yZD0iRW50ZXIgdGhlIHBhc3N3b3JkIGhlcmUiIC8+PC9FbmNyeXB0aW9uPjwvU3RvcmFnZUluZm8+PFJldGVudGlvbkluZm8gUmVzdG9yZVBvaW50c0NvdW50PSIxNCIgLz48Q2FjaGVJbmZvIEVuYWJsZWQ9IlRydWUiIFNpemVHQj0iNSI+PExvY2F0aW9uIFR5cGU9IjEiIERyaXZlTmFtZT0iQzpcIiBSZWxhdGl2ZVBhdGg9IldpbmRvd3NcVGVtcFxWZWVhbUFnZW50XENhY2hlIiAvPjwvQ2FjaGVJbmZvPjxHdWVzdEluZm8+PEFwcGxpY2F0aW9ucyBFbmFibGVkPSJGYWxzZSIgUHJvY2Vzc1RyYW5zYWN0aW9uTG9ncz0iVHJ1ZSI+PFNxbCBNb2RlPSIxIj48Q3JlZGVudGlhbHMgVXNlck5hbWU9IiIgUGFzc3dvcmQ9IiIgLz48QmFja3VwIEVuYWJsZWQ9IkZhbHNlIiBFeHBpcmFibGU9IlRydWUiIEJhY2t1cE1pbnV0ZXM9IjE1IiBFeHBpcmVEYXlzPSIxNSIgLz48L1NxbD48T3JhY2xlIE1vZGU9IjAiIExpZmV0aW1lSG91cnM9IjI0IiBTaXplR0I9IjEwIiBBY2NvdW50VHlwZT0iMCI+PENyZWRlbnRpYWxzIFVzZXJOYW1lPSIiIFBhc3N3b3JkPSIiIC8+PEJhY2t1cCBFbmFibGVkPSJGYWxzZSIgRXhwaXJhYmxlPSJUcnVlIiBCYWNrdXBNaW51dGVzPSIxNSIgRXhwaXJlRGF5cz0iMTUiIC8+PC9PcmFjbGU+PFNoYXJlUG9pbnQ+PENyZWRlbnRpYWxzIFVzZXJOYW1lPSIiIFBhc3N3b3JkPSIiIC8+PC9TaGFyZVBvaW50PjxTY3JpcHQgTW9kZT0iMCIgUHJlRnJlZXplUGF0aD0iIiBQb3N0VGhhd1BhdGg9IiI+PENyZWRlbnRpYWxzIFVzZXJOYW1lPSIiIFBhc3N3b3JkPSIiIC8+PC9TY3JpcHQ+PC9BcHBsaWNhdGlvbnM+PEluZGV4aW5nIEVuYWJsZWQ9IkZhbHNlIiBUeXBlPSIzIj48SW5jbHVkZWRGb2xkZXJzIC8+PEV4Y2x1ZGVkRm9sZGVycz48U3RyaW5nIHZhbHVlPSIld2luZGlyJSIgLz48U3RyaW5nIHZhbHVlPSIlUHJvZ3JhbUZpbGVzJSIgLz48U3RyaW5nIHZhbHVlPSIlUHJvZ3JhbUZpbGVzKHg4NiklIiAvPjxTdHJpbmcgdmFsdWU9IiVQcm9ncmFtVzY0MzIlIiAvPjxTdHJpbmcgdmFsdWU9IiVURU1QJSIgLz48L0V4Y2x1ZGVkRm9sZGVycz48L0luZGV4aW5nPjwvR3Vlc3RJbmZvPjxTY2hlZHVsZUluZm8gUnVuTWFudWFsbHk9IkZhbHNlIiBSZXN1bWVNaXNzZWRCYWNrdXA9IlRydWUiIEVqZWN0UmVtb3ZhYmxlU3RvcmFnZU9uY2VCYWNrdXBJc0NvbXBsZXRlZD0iRmFsc2UiIEF0TG9nT2ZmPSJGYWxzZSIgQXRMb2NrPSJGYWxzZSIgQXRTdG9yYWdlQXR0YWNoPSJUcnVlIiBVc2VCYWNrdXBXaW5kb3c9IkZhbHNlIiBWZXJzaW9uPSIxIiBMaW1pdEJhY2t1cHNGcmVxdWVuY3k9IlRydWUiIE1heEJhY2t1cHNGcmVxdWVuY3k9IjEiIENvbXBsZXRpb25Nb2RlPSIwIiBGcmVxdWVuY3lUaW1lVW5pdD0iMiIgVHlwZT0iMSI+PERhaWx5SW5mbyBUaW1lPSIxMC8wOS8yMDE3IDAwOjMwOjAwIiBLaW5kPSIwIiBEYXlzPSJTdW5kYXksIE1vbmRheSwgVHVlc2RheSwgV2VkbmVzZGF5LCBUaHVyc2RheSwgRnJpZGF5LCBTYXR1cmRheSIgLz48U3ludGhldGljRnVsbCBFbmFibGVkPSJGYWxzZSIgLz48QWN0aXZlRnVsbCBFbmFibGVkPSJGYWxzZSIgLz48UmV0cnlJbmZvIEVuYWJsZWQ9IlRydWUiIFRpbWVzPSIzIiBUaW1lb3V0TWludXRlcz0iMTAiIC8+PC9TY2hlZHVsZUluZm8+PFN0YXRpc3RpY3NJbmZvIEF2ZXJhZ2VEdXJhdGlvbj0iMDA6MDQ6NDYuNTY5MDAwMCIgVG90YWxTaXplPSI1NTU4MTc1MzM0NCIgTGFzdFBvaW50U2l6ZT0iMzg5NjYwNjcyIiAvPjwvSm9iSW5mbz48L0RhdGE+PE5vdGlmaWNhdGlvbnM+PE5vdGlmaWNhdGlvbiBNZXNzYWdlPSJDb25maWd1cmF0aW9uIGhhcyBiZWVuIGV4cG9ydGVkIHRvIEM6XHRlbXBcZGVmYXVsdENvbmZpZy54bWwiIC8+PC9Ob3RpZmljYXRpb25zPjwvRXhlY3V0aW9uUmVzdWx0Pg=='
                [IO.File]::WriteAllBytes($ConfigPath, [Convert]::FromBase64String($NetworkConfig))
                [xml]$xml = Get-Content $ConfigPath
                $xml.ExecutionResult.data.JobInfo.StorageInfo.Encryption.Key.Password = $EncodedEncryptionPassword
                $xml.ExecutionResult.data.JobInfo.RetentionInfo.RestorePointsCount = $RestorePoints.ToString()
                $xml.ExecutionResult.data.JobInfo.TargetInfo.Path = $NetworkPath
                $xml.Save($ConfigPath)
                $String = Get-Content $ConfigPath | ForEach-Object {$_.trim()}
                ($String -join '').Trim() | Out-File $ConfigPath -NoNewline -Encoding ascii
            }
            if($Type -eq 'Local') {

                $LocalConfig = 'PEV4ZWN1dGlvblJlc3VsdCBWZXJzaW9uPSIyLjAuMC43MDAiIEV4aXRDb2RlPSIwIj48RGF0YT48QXBwbGljYXRpb25TZXR0aW5ncyBDcnlwdFR5cGU9IjEwIiBDcnlwdElkPSIwMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDAiIENoZWNrVXBkYXRlcz0iRmFsc2UiIERpc2FibGVTY2hlZHVsZWRCYWNrdXBzPSJGYWxzZSIgRGlzYWJsZUNvbnRyb2xQYW5lbE5vdGlmaWNhdGlvbj0iRmFsc2UiIFRocm90dGxlQmFja3VwQWN0aXZpdHk9IlRydWUiIFNob3dCYWNrdXBEdXJhdGlvbj0iRmFsc2UiIERpc2FibGVCYWNrdXBPdmVyTWV0ZXJlZENvbm5lY3Rpb249IlRydWUiIExvY2tEb3duTW9kZT0iRmFsc2UiIFNlcnZpY2VQcm92aWRlck1vZGU9IkZhbHNlIiBMYXN0Q2hlY2tGb3JVcGRhdGVzPSIxMC8zMC8yMDE3IDE2OjE3OjU5IiBMb2dvVGV4dD0iaS50LkJBQ0tVUCIgLz48Sm9iSW5mbyBDcnlwdFR5cGU9IjEwIiBDcnlwdElkPSIwMDAwMDAwMC0wMDAwLTAwMDAtMDAwMC0wMDAwMDAwMDAwMDAiPjxTb3VyY2VJbmZvPjxFcERpc2tGaWx0ZXIgQmFja3VwTW9kZT0iMCIgQmFja3VwU3lzdGVtU3RhdGU9IkZhbHNlIiBCYWNrdXBVc2VyRm9sZGVycz0iRmFsc2UiPjxJbmNsdWRlTWFza3MgLz48RXhjbHVkZU1hc2tzIC8+PC9FcERpc2tGaWx0ZXI+PC9Tb3VyY2VJbmZvPjxUYXJnZXRJbmZvIFR5cGU9IjEiIERyaXZlTmFtZT0iSTpcIiBSZWxhdGl2ZVBhdGg9ImJhY2t1cHNcIiAvPjxTdG9yYWdlSW5mbyBDb21wcmVzc2lvbkxldmVsPSI1IiBCbG9ja1NpemU9IjMiPjxFbmNyeXB0aW9uIEVuYWJsZWQ9IlRydWUiPjxLZXkgSGludD0iYVM1MExrNVBWeUJUZEdGdVpHRnlaQ0JKYldGblpTQlFZWE56ZDI5eVpBPT0iIFBhc3N3b3JkPSJFbnRlciB0aGUgcGFzc3dvcmQgaGVyZSIgLz48L0VuY3J5cHRpb24+PC9TdG9yYWdlSW5mbz48UmV0ZW50aW9uSW5mbyBSZXN0b3JlUG9pbnRzQ291bnQ9IjE0IiAvPjxDYWNoZUluZm8gRW5hYmxlZD0iRmFsc2UiIC8+PEd1ZXN0SW5mbz48QXBwbGljYXRpb25zIEVuYWJsZWQ9IkZhbHNlIiBQcm9jZXNzVHJhbnNhY3Rpb25Mb2dzPSJUcnVlIj48U3FsIE1vZGU9IjEiPjxDcmVkZW50aWFscyBVc2VyTmFtZT0iIiBQYXNzd29yZD0iIiAvPjxCYWNrdXAgRW5hYmxlZD0iRmFsc2UiIEV4cGlyYWJsZT0iVHJ1ZSIgQmFja3VwTWludXRlcz0iMTUiIEV4cGlyZURheXM9IjE1IiAvPjwvU3FsPjxPcmFjbGUgTW9kZT0iMCIgTGlmZXRpbWVIb3Vycz0iMjQiIFNpemVHQj0iMTAiIEFjY291bnRUeXBlPSIwIj48Q3JlZGVudGlhbHMgVXNlck5hbWU9IiIgUGFzc3dvcmQ9IiIgLz48QmFja3VwIEVuYWJsZWQ9IkZhbHNlIiBFeHBpcmFibGU9IlRydWUiIEJhY2t1cE1pbnV0ZXM9IjE1IiBFeHBpcmVEYXlzPSIxNSIgLz48L09yYWNsZT48U2hhcmVQb2ludD48Q3JlZGVudGlhbHMgVXNlck5hbWU9IiIgUGFzc3dvcmQ9IiIgLz48L1NoYXJlUG9pbnQ+PFNjcmlwdCBNb2RlPSIwIiBQcmVGcmVlemVQYXRoPSIiIFBvc3RUaGF3UGF0aD0iIj48Q3JlZGVudGlhbHMgVXNlck5hbWU9IiIgUGFzc3dvcmQ9IiIgLz48L1NjcmlwdD48L0FwcGxpY2F0aW9ucz48SW5kZXhpbmcgRW5hYmxlZD0iRmFsc2UiIFR5cGU9IjMiPjxJbmNsdWRlZEZvbGRlcnMgLz48RXhjbHVkZWRGb2xkZXJzPjxTdHJpbmcgdmFsdWU9IiV3aW5kaXIlIiAvPjxTdHJpbmcgdmFsdWU9IiVQcm9ncmFtRmlsZXMlIiAvPjxTdHJpbmcgdmFsdWU9IiVQcm9ncmFtRmlsZXMoeDg2KSUiIC8+PFN0cmluZyB2YWx1ZT0iJVByb2dyYW1XNjQzMiUiIC8+PFN0cmluZyB2YWx1ZT0iJVRFTVAlIiAvPjwvRXhjbHVkZWRGb2xkZXJzPjwvSW5kZXhpbmc+PC9HdWVzdEluZm8+PFNjaGVkdWxlSW5mbyBSdW5NYW51YWxseT0iRmFsc2UiIFJlc3VtZU1pc3NlZEJhY2t1cD0iVHJ1ZSIgRWplY3RSZW1vdmFibGVTdG9yYWdlT25jZUJhY2t1cElzQ29tcGxldGVkPSJGYWxzZSIgQXRMb2dPZmY9IkZhbHNlIiBBdExvY2s9IkZhbHNlIiBBdFN0b3JhZ2VBdHRhY2g9IlRydWUiIFVzZUJhY2t1cFdpbmRvdz0iRmFsc2UiIFZlcnNpb249IjEiIExpbWl0QmFja3Vwc0ZyZXF1ZW5jeT0iVHJ1ZSIgTWF4QmFja3Vwc0ZyZXF1ZW5jeT0iMiIgQ29tcGxldGlvbk1vZGU9IjAiIEZyZXF1ZW5jeVRpbWVVbml0PSIxIiBUeXBlPSIxIj48RGFpbHlJbmZvIFRpbWU9IjEwLzMwLzIwMTcgMDA6MzA6MDAiIEtpbmQ9IjAiIERheXM9IlN1bmRheSwgTW9uZGF5LCBUdWVzZGF5LCBXZWRuZXNkYXksIFRodXJzZGF5LCBGcmlkYXksIFNhdHVyZGF5IiAvPjxTeW50aGV0aWNGdWxsIEVuYWJsZWQ9IkZhbHNlIiAvPjxBY3RpdmVGdWxsIEVuYWJsZWQ9IkZhbHNlIiAvPjxSZXRyeUluZm8gRW5hYmxlZD0iVHJ1ZSIgVGltZXM9IjMiIFRpbWVvdXRNaW51dGVzPSIxMCIgLz48L1NjaGVkdWxlSW5mbz48U3RhdGlzdGljc0luZm8gQXZlcmFnZUR1cmF0aW9uPSIwMDowMDowMCIgVG90YWxTaXplPSIwIiBMYXN0UG9pbnRTaXplPSIwIiAvPjwvSm9iSW5mbz48L0RhdGE+PE5vdGlmaWNhdGlvbnM+PE5vdGlmaWNhdGlvbiBNZXNzYWdlPSJDb25maWd1cmF0aW9uIGhhcyBiZWVuIGV4cG9ydGVkIHRvIEM6XHRlbXBcTG9jYWxDb25maWcueG1sIiAvPjwvTm90aWZpY2F0aW9ucz48L0V4ZWN1dGlvblJlc3VsdD4='
                [IO.File]::WriteAllBytes($ConfigPath, [Convert]::FromBase64String($LocalConfig))
                [xml]$xml = Get-Content $ConfigPath

                # Get Destination, process all USB Drives
                $USBDrives = Get-CimInstance -ClassName win32_diskdrive | Where-Object{$_.interfacetype -eq "USB"} | ForEach-Object{Get-CimInstance -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID=`"$($_.DeviceID.replace('\','\\'))`"} WHERE AssocClass = Win32_DiskDriveToDiskPartition"} |  ForEach-Object{Get-CimInstance -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID=`"$($_.DeviceID)`"} WHERE AssocClass = Win32_LogicalDiskToPartition"} | ForEach-Object{$_.deviceid}
                if (!$USBDrives) {
                    Write-Output "ERROR: No USB drives found."
                    Break
                }
                # Find USB drive with a Backup folder on the root or the largest one
                $BackupFolders = Get-ChildItem $($USBDrives.replace(':',':\')) -Filter 'Backup*'
                if ($BackupFolders) {
                    Write-Verbose "Existing backup folder fould: $($BackupFolders.FullName -join(', '))"
                    $DestinationDrive = Get-PSDrive -Name $BackupFolders.Parent.Name.trim(':\') | Sort-Object ($_.Used + $_.Free) -Descending | Select-Object -First 1
                    $Destination = ($BackupFolders | Where-Object {$_.Parent.Name -eq $DestinationDrive.Root}).FullName
                    $DriveName = $DestinationDrive.Root
                    $RelativePath = $Destination.trim($DestinationDrive.Root) + "\"

                } else {
                    $DestinationDrive = Get-PSDrive -Name $USBDrives.Trim(':') | Sort-Object ($_.Used + $_.Free) -Descending | Select-Object -First 1
                    $Destination = Join-Path $DestinationDrive.Root 'Backup'
                    $DriveName = $DestinationDrive.Root
                    $RelativePath = 'Backup\'
                }
                Write-Verbose "Destination: $Destination"

                $xml.ExecutionResult.data.JobInfo.StorageInfo.Encryption.Key.Password = $EncodedEncryptionPassword
                $xml.ExecutionResult.data.JobInfo.RetentionInfo.RestorePointsCount = $RestorePoints.ToString()
                $xml.ExecutionResult.data.JobInfo.TargetInfo.DriveName = $DriveName
                $xml.ExecutionResult.data.JobInfo.TargetInfo.RelativePath = $RelativePath

                $xml.Save($ConfigPath)
                $String = Get-Content $ConfigPath | ForEach-Object {$_.trim()}
                ($String -join '').Trim() | Out-File $ConfigPath -NoNewline -Encoding ascii
            }
        }

        Catch{
            Write-Output "There was an error building the config."
            Write-Output $Error[0]
            Break
        }
    }
    End{
        If($?){
            Write-Output "Configuration file created: $ConfigPath"
        }
    }
}