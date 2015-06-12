configuration Notepad2
{
    Import-DscResource -ModuleName @{ModuleName='xPSDesiredStateConfiguration';ModuleVersion='3.3.0.0'}
        xPackage Notepad2
        { 
            Name =  'Notepad2'
            Path = 'http://www.flos-freeware.ch/zip/Notepad2_4.2.25_x64.exe'
            Arguments = '/quiet'
            ProductId = ''
            InstalledCheckRegKey = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Notepad2' 
            InstalledCheckRegValueName = 'DisplayName'
            InstalledCheckRegValueData = 'Notepad2 (Notepad Replacement)' 
        }
}

$outputPath = Join-Path $env:temp Notepad2
Notepad2 -OutputPath $outputPath -ConfigurationData $ConfigurationData
Start-DscConfiguration -Path $outputPath -Wait -Verbose -force

# Cleanup all copies of the configuration
del $outputPath -recurse -force
Remove-DscConfigurationDocument -Stage Current -Force
Remove-DscConfigurationDocument -Stage Pending -Force
Remove-DscConfigurationDocument -Stage Previous -Force