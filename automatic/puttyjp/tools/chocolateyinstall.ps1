$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'http://hp.vector.co.jp/authors/VA024651/download/file/putty-0.71-jp20190410.zip'
  checksum       = '2647b73f072e168bd64b1002c7023e9dd51a6bbacb241a9eb707059a601bb18b'
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
