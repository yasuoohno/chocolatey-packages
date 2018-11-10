$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://www.fossil-scm.org/xfer/uv/fossil-w32-2.7.zip'
  checksum      = 'd245dd626f755bfce65265e4b5a5000df15ff3e1c0f4da0838b3bbd953eb32a0'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
