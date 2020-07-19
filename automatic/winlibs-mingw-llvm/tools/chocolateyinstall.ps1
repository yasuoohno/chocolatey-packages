$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$binPath               = "$toolsDir\mingw64\bin"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url64bit       = 'https://github.com/brechtsanders/winlibs_mingw/releases/download/10.1.0-10.0.0-7.0.0-r3/winlibs-x86_64-posix-seh-gcc-10.1.0-llvm-10.0.0-mingw-w64-7.0.0-r3.7z'
  checksum64     = '376354566491b56b87ff2bc9a28971902967229a51d541293c75f53db3f490fb'
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
