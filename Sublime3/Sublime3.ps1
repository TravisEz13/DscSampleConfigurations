configuration SublimeSetup
{
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    xPackage sublime
    {
        Path = 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203083%20x64%20Setup.exe'
        Name = 'Sublime'
        ProductId = ''
        InstalledCheckRegKey = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Sublime Text 3_is1'
        InstalledCheckRegValueName = 'Publisher' 
        InstalledCheckRegValueData = 'Sublime HQ Pty Ltd'
        Arguments = '/silent /norestart'
    }
}

$outputPath = Join-Path $env:temp SublimeSetup
SublimeSetup -OutputPath $outputPath -ConfigurationData $ConfigurationData
Start-DscConfiguration -Path $outputPath -Wait -Verbose -force

# Cleanup all copies of the configuration
del $outputPath -recurse -force
Remove-DscConfigurationDocument -Stage Current -Force
Remove-DscConfigurationDocument -Stage Pending -Force
Remove-DscConfigurationDocument -Stage Previous -Force