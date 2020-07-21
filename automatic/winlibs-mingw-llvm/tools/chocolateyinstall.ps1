$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir            = "$(Get-ToolsLocation)"
$binPath               = "$installDir\mingw64\bin"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $installDir
  url64bit       = ''
  checksum64     = ''
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

#
# Disable auto shimming.
#
$files = get-childitem $toolsDir -include *.exe -recurse

foreach ($file in $files) {
  #generate an ignore file
  New-Item "$file.ignore" -type file -force | Out-Null
}

#
# add path
#
Install-ChocolateyPath -PathToInstall "$binPath" -PathType 'Machine'
