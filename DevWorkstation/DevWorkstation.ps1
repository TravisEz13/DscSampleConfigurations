configuration InstallTools
{
  Import-DscResource -ModuleName cChoco


    Import-DscResource -Module PackageManagementProviderResource

  PSModule pester
  {
      Ensure            = 'present' 
      Name              = 'Pester'
      Repository        = 'PSGallery'
      InstallationPolicy='trusted'     
  }                               
  PSModule steroids
  {
      Ensure            = 'present' 
      Name              = 'IseSteroids'
      Repository        = 'PSGallery'
      InstallationPolicy='trusted'     
  }                               
  PSModule poshgit
  {
      Ensure            = 'present' 
      Name              = 'Posh-git'
      Repository        = 'PSGallery'
      InstallationPolicy='trusted'     
  }                               
  PSModule AzureRM
  {
      Ensure            = 'present' 
      Name              = 'AzureRM'
      Repository        = 'PSGallery'
      InstallationPolicy='trusted'     
  }     
  <#Script updateAzureRM
  {
    TestScript = { return $false}
    SetScript = { 
      Import-module AzureRM
      Update-AzureRM
    }
    GetScript = {return @{}}
  } #>                         
  cChocoInstaller choco
  {
    InstallDir = 'C:\choco'
  }
  <# seemed to wait on input
  cChocoPackageInstaller 'notepad++'
  {
    Name = 'notepadplusplus.install'
  }
  #>
  cChocoPackageInstaller '7zip'
  {
    Name = '7zip.install'
  }
  <#
  cChocoPackageInstaller 'git'
  {
    Name = 'git.install'
  }#>
  cChocoPackageInstaller 'sysinternals'
  {
    Name = 'sysinternals'
   
  }
  cChocoPackageInstaller 'notepad2'
  {
    Name = 'notepad2'
   
  }
  cChocoPackageInstaller 'baretail'
  {
    Name = 'baretail'
  }
  <#
  cChocoPackageInstaller 'beyondcompare'
  {
    Name = 'beyondcompare'
  }
  #>
  cChocoPackageInstaller 'webpicmd'
  {
    Name = 'webpicmd'
  }
  <#
  cChocoPackageInstaller 'visualstudiocode'
  {
    Name = 'visualstudiocode'
  }
  #>
  
  
}

InstallTools -OutputPath $env:temp\InstallTools
Start-DscConfiguration -Wait -Verbose -Path $env:temp\InstallTools