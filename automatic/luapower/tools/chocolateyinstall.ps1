$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$binPath               = "$toolsDir\luapower-all-2019-01-28\"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://github.com/luapower/luapower-all/archive/2019-01-28.zip'
  checksum       = '05ed17043b825d176c9f6c955625e67aa042ff99f2e9b308b3132ad67335ae30'
  checksumType   = 'sha256'
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
# add binfile for wrapper
#
Install-BinFile "luajit" "$binPath\luajit.cmd"
