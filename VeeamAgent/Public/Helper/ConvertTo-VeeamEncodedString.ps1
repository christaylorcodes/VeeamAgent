function ConvertTo-VeeamEncodedString {
    [OutputType([string])]
    [CmdletBinding()]
    param (
        [string]$String
    )
    $Bytes = [System.Text.Encoding]::UTF8.GetBytes($String)
   [Convert]::ToBase64String($Bytes)
}