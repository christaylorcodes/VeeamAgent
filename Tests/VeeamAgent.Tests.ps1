$Verbose = @{}
if($env:APPVEYOR_REPO_BRANCH -and $env:APPVEYOR_REPO_BRANCH -notlike "master")
{
    $Verbose.add("Verbose",$True)
}

$PSVersion = $PSVersionTable.PSVersion.Major
Import-Module $PSScriptRoot\..\VeeamAgent\VeeamAgent.psm1 -Force

$ServiceName = 'VeeamEndpointBackupSvc'

#Integration test example
Describe "Install-VeeamAgent  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'should install' {
            try { 
                Install-VeeamAgent -ErrorAction Stop
                $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
                $Service | Should -Not -BeNullOrEmpty
            }
            catch { $_ | Should -BeNullOrEmpty }
        }
    }
}

Describe "Get-VeeamAgentVersion  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'should return version' {
            try { 
                $Version = Get-VeeamAgentVersion                
                $Version | Should -BeGreaterOrEqual 4
            }
            catch { $_ | Should -BeNullOrEmpty }
        }
    }
}

Describe "Remove-VeeamAgent  PS$PSVersion Integrations tests" {

    Context 'Strict mode' {

        Set-StrictMode -Version latest

        It 'should uninstall' {
            try{
                Remove-VeeamAgent -ErrorAction Stop 
                $Service = Get-Service $ServiceName -ErrorAction SilentlyContinue
                $Service | Should -BeNullOrEmpty    
            }
            catch{ $_ | Should -BeNullOrEmpty }
        }
    }
}