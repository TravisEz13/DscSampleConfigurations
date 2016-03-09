Function Get-ProductEntryList
{
    param
    (
        [string] $Name,
        [string] $IdentifyingNumber,
        [string] $InstalledCheckRegHive = 'LocalMachine',
        [string] $InstalledCheckRegKey,
        [string] $InstalledCheckRegValueName,
        [string] $InstalledCheckRegValueData
    )

    $keys = @(
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
        'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
      )
    foreach($key in $keys)
    {
      $subKeys = Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
      foreach($subKey in $subKeys)
      {
        $path = (join-path $key $subKey.PSChildName)
        $item = Get-ItemProperty -Path $path -ErrorAction SilentlyContinue
        if($item.PSChildName -match '^[{|\(]?[0-9A-F]{8}[-]?([0-9A-F]{4}[-]?){3}[0-9A-F]{12}[\)|}]?$')
        {
          Write-Output ([PSCustomObject] @{
            ProductId = $item.PSChildName
            DisplayName = $item.DisplayName
            DisplayVersion = $item.DisplayVersion
            InstallDate = $item.InstallDate
            })
        }          
      } 
    }
}
