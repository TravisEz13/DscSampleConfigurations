configuration foo
{
  Import-DscResource -ModuleName xWindowsUpdate
  Registry DarkTheme
  {
    Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
    ValueName = 'AppsUseLightTheme'
    ValueData = 0
    ValueType = 'Dword'
  }
}

foo -OutputPath $env:temp\wuUpToDate
Start-DscConfiguration -Path $env:temp\wuUpToDate -wait -verbose -force