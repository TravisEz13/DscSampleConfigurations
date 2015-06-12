PowerShell DSC Configuration Samples
====================================

MSU / Stand Alone Windows Update Samples
----------------------------------------

#### RSAT For Windows 8.1 / Server 2012R2

* [Install Resources](RSAT8_1/SetupPrerequisites.ps1)
* [Configuration](RSAT8_1/Rsat8_1Install.ps1)
#### WMF 5 Installation

* [Install Resources](WMF5_Install/SetupPrerequisites.ps1)
* [Configuration](WMF5_Install/WMF5Install.ps1)

Non-MSI Setup Samples
---------------------
#### Sublime 3

* [Install Resources](Sublime3/SetupPrerequisites.ps1)
* [Configuration](Sublime3/Sublime3.ps1)

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

Installing Resources
---------------------
Most samples provided in this repo provide a SetupPrerequisites which will work to install the Resources required to run the configuration on WMF5/PowerShell5 and higher.  If you are running PowerShell 4, you can see the [same file](WMF5_Install/SetupPrerequisites.ps1) for installing WMF 5, to do the same thing on PowerShell 4.