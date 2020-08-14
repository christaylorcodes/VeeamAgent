#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue -Recurse )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue -Recurse )

#Dot source the files
Foreach($import in @($Public + $Private)) {
    Try {
        . $import.fullname
    } Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Read in or create an initial config file and variable
# Export Public functions ($Public.BaseName) for WIP modules
Export-ModuleMember -Function $Public.Basename

# Set variables visible to the module and its functions only
$script:DefaultDownloadURL = 'https://download2.veeam.com/VeeamAgentWindows_4.0.1.2169.zip'
$script:DefaultMD5 = '6db951e56aeea0b6f61e70ba92564c03'