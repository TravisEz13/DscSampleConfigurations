configuration VsCode
{
    Param([pscredential] $crendetial = (Get-Credential -UserName "${env:USERDOMAIN}\${env:USERNAME}" -Message 'enter creds') )

   Import-DscResource -ModuleName @{ModuleName='xPSDesiredStateConfiguration';ModuleVersion='3.3.0.0'}
   Node $allnodes.NodeName
   {
        xPackage VsCode
        { 
            Name =  'VsCode'
            Path = 'http://download.microsoft.com/download/0/D/5/0D57186C-834B-463A-AECB-BC55A8E466AE/VSCodeSetup.exe'
            ProductId = ''
            Arguments = '-s'
            InstalledCheckRegHive = 'CurrentUser' 
            InstalledCheckRegKey = 'Software\Microsoft\Windows\CurrentVersion\Uninstall\Code' 
            InstalledCheckRegValueName = 'DisplayName'
            InstalledCheckRegValueData = 'Code' 
            PsDscRunAsCredential = $crendetial
        }
    }
}

$ConfigurationData = @{
    AllNodes = @(
        @{
            NodeName="*"
            PSDscAllowPlainTextPassword=$true
         }
        @{
            NodeName="localhost"
         }
   )
}

$outputPath = Join-Path $env:temp VsCode
VsCode -OutputPath $outputPath -ConfigurationData $ConfigurationData
Start-DscConfiguration -Path $outputPath -Wait -Verbose -force

# Cleanup all copies of the configuration
del $outputPath -recurse -force
Remove-DscConfigurationDocument -Stage Current -Force
Remove-DscConfigurationDocument -Stage Pending -Force
Remove-DscConfigurationDocument -Stage Previous -Force