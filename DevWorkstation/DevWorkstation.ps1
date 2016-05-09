configuration InstallTools
{
  Import-DscResource -ModuleName cChoco
  Import-dscresource -ModuleName xpsdesiredstateconfiguration
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
    $chocoPackages = @('7Zip','sysinternals','notepad2','git.install','baretail','chocolateygui','webpicmd','cmake.portable','vim')                          
    foreach($chocoPackage in $chocoPackages)
    {
        cChocoPackageInstaller $chocoPackage
        {
            Name = $chocoPackage
        }
    }
  <#
  cChocoPackageInstaller 'beyondcompare'
  {
    Name = 'beyondcompare'
  }
  #>
  
  <#xPackage dotnet
  {
    Name = 'Microsoft Dotnet CLI for Windows (1.0.0.001598 )'
    Path = 'https://dotnetcli.blob.core.windows.net/dotnet/beta/Installers/1.0.0.001598/dotnet-win-x64.1.0.0.001598.exe'
    ProductId = '{7DE53F51-B432-412B-9447-943A5138457A}'
    Arguments =  '/install /passive /norestart'
    
  } #> <#
  cChocoPackageInstaller 'visualstudiocode'
  {
    Name = 'visualstudiocode'
  }
  #>
  Environment chocolatelyInstall
  {
    Name = 'chocolatelyInstall'
    value = 'C:\choco\bin'
  }

  
  
}

InstallTools -OutputPath $env:temp\InstallTools
Start-DscConfiguration -Wait -Verbose -Path $env:temp\InstallTools