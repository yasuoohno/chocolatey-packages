$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$binPath               = "$toolsDir\luapower-all-2018-11-11\"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'https://github.com/luapower/luapower-all/archive/2018-11-11.zip'
  checksum       = '8f97f4cf7ae09e7c8ce7edbd595ae2dbf33d3d01fbddce415974b77350f388ff'
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
