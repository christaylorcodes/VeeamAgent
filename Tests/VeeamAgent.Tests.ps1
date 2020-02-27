$Verbose = @{}
if($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master")
{
    $Verbose.add("Verbose",$True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module $PSScriptRoot\..\VeeamAgent\VeeamAgent.psm1 -Force

#Integration test example
Describe "Install-VeeamAgent  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'should install' {
            $ServiceName = 'VeeamEndpointBackupSvc'
            try { Install-VeeamAgent -ErrorAction Stop }
            catch { $_ | Should -Be $null }
            $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
            $Service.Name | Should -Be $ServiceName
        }
        It 'should uninstall' {
            try{ Remove-VeeamAgent -ErrorAction Stop }
            catch{ $_ | Should -Be $null }
            $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
            $Service | Should -Be $null 
        }

    }
}