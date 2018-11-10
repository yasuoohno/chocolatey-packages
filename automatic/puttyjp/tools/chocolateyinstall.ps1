$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'http://hp.vector.co.jp/authors/VA024651/download/file/putty-0.70-jp20170713.zip'
  checksum       = '09324063971f12cecd5ce1f83114683101d7a440ab14aad7fa3ac06fb0c7fe70'
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
