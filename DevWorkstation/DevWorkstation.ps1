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
  Script updateAzureRM
  {
    TestScript = { 
    import-module azurerm
    $azureRmModule = (get-module azurerm).Invoke({$AzureRMModules}, @())
      foreach($moduleName in $azureRmModule.keys) {
        $psGalleryModule = find-module -Name $moduleName
        $installedModule = (get-module -Name $moduleName -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1)
        if($psGallery.Version -gt $installedModule.Version){
          return $false
        }
      }
      return $true
    }
    SetScript = { 
      import-module azurerm
      $azureRmModule = (get-module azurerm).Invoke({$AzureRMModules}, @())
      foreach($moduleName in $azureRmModule.keys) {
        $psGalleryModule = find-module -Name $moduleName
        $installedModule = (get-module -Name $moduleName -ListAvailable | Sort-Object -Property Version -Descending | Select-Object -First 1)
        if($psGallery.Version -gt $installedModule.Version){
          $psGalleryModule | Install-module -force
        }
      }
      return $true
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