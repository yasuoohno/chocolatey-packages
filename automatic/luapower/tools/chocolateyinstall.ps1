﻿$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$binPath               = "$toolsDir\luapower-all-2020-07-19\"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://github.com/luapower/luapower-all/archive/2020-07-19.zip'
  checksum       = '4018a257f29cb26d2aafc111dc07be8f9117d7f882dd28188bda1564e19111be'
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
