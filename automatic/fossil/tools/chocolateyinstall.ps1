$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = ''
  checksum      = ''
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
