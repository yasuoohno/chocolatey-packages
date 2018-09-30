$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://www.fossil-scm.org/xfer/uv/fossil-w32-2.7.zip'
  checksum      = '3f708bac91cbf7b8824cbbe16b2ef692efd33cff'
  checksumType  = 'sha1'
}

Install-ChocolateyZipPackage @packageArgs
