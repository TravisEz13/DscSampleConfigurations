# Make sure you   Set-ExecutionPolicy remotesigned   or less string

Set-WSManQuickConfig -Force

$nugetPath = Join-Path $env:temp nuget.exe
if(!(Test-Path $nugetPath))
{
    Invoke-WebRequest -UseBasicParsing -Uri https://nuget.org/nuget.exe -OutFile $nugetPath
}

&$nugetPath install XWindowsUpdate -source https://www.powershellgallery.com/api/v2 -outputDirectory "$env:programfiles\WindowsPowerShell\Modules\ " -ExcludeVersion 
