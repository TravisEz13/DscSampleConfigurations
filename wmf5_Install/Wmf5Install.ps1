Set-ExecutionPolicy remotesigned
Set-WSManQuickConfig -Force
$nugetPath = Join-Path $env:temp nuget.exe
if(!(Test-Path $nugetPath))
{
    Invoke-WebRequest -UseBasicParsing -Uri https://nuget.org/nuget.exe -OutFile $nugetPath
}

&$nugetPath install XWindowsUpdate -source https://www.powershellgallery.com/api/v2 -outputDirectory "$env:programfiles\WindowsPowerShell\Modules\ " -ExcludeVersion 


Configuration WMF5Install
{
   Import-DscResource -ModuleName xWindowsUpdate
   Node localhost
   {
      xHotfix HotfixInstall
      {
          Path = 'E:\WindowsBlue-KB3055381-x64.msu'
          Id = 'KB3055381'
          Ensure = 'Present'
      }
       LocalConfigurationManager
       {
        RebootNodeIfNeeded = $true
       }
   }
}

$outputPath = Join-Path $env:temp Wmf5Install
WMF5Install -OutputPath $outputPath
Set-DscLocalConfigurationManager -Path $outputPath -Verbose
Start-DscConfiguration -Path $outputPath -Wait -Verbose -force
