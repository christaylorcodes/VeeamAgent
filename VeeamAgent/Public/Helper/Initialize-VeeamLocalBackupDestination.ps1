function Initialize-VeeamLocalBackupDestination {
    [OutputType([string])]
    [CmdletBinding()]
    param ()

    # Get Destination, process all USB Drives
    $USBDrives = Get-CimInstance -ClassName win32_diskdrive | `
        Where-Object{$_.interfacetype -eq "USB"} | `
        ForEach-Object{
            $Query = "ASSOCIATORS OF {Win32_DiskDrive.DeviceID=`"$($_.DeviceID.replace('\','\\'))`"} WHERE AssocClass = Win32_DiskDriveToDiskPartition"
            Get-CimInstance -Query $Query
        } | `
        ForEach-Object{
            $Query = "ASSOCIATORS OF {Win32_DiskPartition.DeviceID=`"$($_.DeviceID)`"} WHERE AssocClass = Win32_LogicalDiskToPartition"
            Get-CimInstance -Query $Query
        } | `
        ForEach-Object{ $_.deviceid }

    if (!$USBDrives) { return Write-Error 'No USB drives found.' }

    # Find USB drive with a Backup folder on the root or the largest one
    $BackupFolders = Get-ChildItem $($USBDrives.replace(':',':\')) -Filter 'Backup*'
    if ($BackupFolders) {
        Write-Verbose "Existing backup folder found: $($BackupFolders.FullName -join(', '))"
        $DestinationDrive = Get-PSDrive -Name $BackupFolders.Parent.Name.trim(':\') | Sort-Object ($_.Used + $_.Free) -Descending | Select-Object -First 1
        $Destination = ($BackupFolders | Where-Object {$_.Parent.Name -eq $DestinationDrive.Root}).FullName
    } else {
        $DestinationDrive = Get-PSDrive -Name $USBDrives.Trim(':') | Sort-Object ($_.Used + $_.Free) -Descending | Select-Object -First 1
        $Destination = Join-Path $DestinationDrive.Root 'Backup'
    }
    $Destination
}