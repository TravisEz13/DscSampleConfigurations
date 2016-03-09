configuration dotnet
{
  Import-dscresource -ModuleName xpsdesiredstateconfiguration
  xPackage dotnet
  {
    Name = 'Microsoft Dotnet CLI for Windows (1.0.0.001598 )'
    Path = 'https://dotnetcli.blob.core.windows.net/dotnet/beta/Installers/1.0.0.001598/dotnet-win-x64.1.0.0.001598.exe'
    ProductId = '{7DE53F51-B432-412B-9447-943A5138457A}'
    Arguments =  '/install /passive /norestart'
    
  }
}
dotnet
Start-DscConfiguration -path .\dotnet -Wait -Verbose -force