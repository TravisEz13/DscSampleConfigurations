PowerShell DSC Configuration Samples
====================================

MSU / Stand Alone Windows Update Samples
----------------------------------------

#### RSAT For Windows 8.1 / Server 2012R2

* [Install Resources](RSAT8_1/SetupPrerequisites.ps1)
* [Configuration](RSAT8_1/Rsat8_1Install.ps1)

#### WMF 5 Installation

* [Install Resources](wmf5_Install/SetupPrerequisites.ps1)
* [Configuration](wmf5_Install/Wmf5Install.ps1)

Non-MSI All-User Setup Samples
---------------------
#### Sublime 3

* [Install Resources](Sublime3/SetupPrerequisites.ps1)
* [Configuration](Sublime3/Sublime3.ps1)

#### Notepad 2

* [Install Resources](Notepad2/SetupPrerequisites.ps1)
* [Configuration](Notepad2/Notepad2.ps1)

Non-MSI Per-User Setup Samples
---------------------
#### Visual Studio Code

* [Install Resources](VsCode/SetupPrerequisites.ps1)
* [Configuration](VsCode/VsCode.ps1)


MSI Setup Example
-----------------
#### Office 2016
I haven't found a good link on how to create the configuration file needed in the arguments.  But here is a link for [office 2013](https://technet.microsoft.com/en-us/library/jj219422.aspx#BKMK_ConfigureCmd)
```PowerShell
configuration SublimeSetup
{
    Import-DscResource -ModuleName xPSDesiredStateConfiguration
    package Office2016
        { 
            Name =  'Office 16 Click-to-Run Licensing Component'
            Path = 'http://go.microsoft.com/fwlink/p/?LinkID=534759'
            Arguments = '/configure "<OfficeDeploymentToolConfiguration.xml>"'
            ProductId = '{10160000-008F-0000-1000-0000000FF1CE}'
        }
}
```

#### dotnet cli

```PowerShell
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
```

Get the version on an MSI
-------------------------
Note: this requries WMF5 or higher
```PowerShell
Invoke-DscResource -name package -Method get -ModuleName PSDesiredStateConfiguration -Property @{
    ProductID='{DD3A1267-1A98-4332-BE1A-1D415C2CC1D8}'
    Name='Microsoft Lync Web App Plug-in'
    Path='C:\whyisthisneeded.msi'
}
```

Installing Resources
---------------------
Most samples provided in this repo provide a SetupPrerequisites which will work to install the Resources required to run the configuration on WMF5/PowerShell5 and higher.  If you are running PowerShell 4, you can see the [same file](WMF5_Install/SetupPrerequisites.ps1) for installing WMF 5, to do the same thing on PowerShell 4.


Get a list of productID and the name for the product
-----------------------------------------------------
I created a function to help find the ProductID and names.
* [Module](ListMsiProductIdse/ListMsiProductIds.ps1)

```Powershell
$items = Get-ProductEntry                                                                                                                                      
$items | Sort-Object -Descending -Property InstallDate           
```