
Configuration RSATInstall
{
   Import-DscResource -ModuleName xWindowsUpdate
   Node localhost
   {
      xHotfix HotfixInstall
      {
          Path = 'http://download.microsoft.com/download/1/8/E/18EA4843-C596-4542-9236-DE46F780806E/Windows8.1-KB2693643-x64.msu'
          Id = 'KB2693643'
          Ensure = 'Present'
      }
       LocalConfigurationManager
       {
        RebootNodeIfNeeded = $true
       }
   }
}

$outputPath = Join-Path $env:temp RSATInstall
RSATInstall -OutputPath $outputPath
Set-DscLocalConfigurationManager -Path $outputPath -Verbose
Start-DscConfiguration -Path $outputPath -Wait -Verbose -force
