$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$binPath               = "$toolsDir\emacs\bin"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url64bit       = 'http://cha.la.coocan.jp/doc/../files/emacs-26.1-simple_ime-no_symbol.zip'
  checksum64     = '54cdee7db680307ceb89ef50ae2522ea81907ded12100b0e6f49f1fc928988f7'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
