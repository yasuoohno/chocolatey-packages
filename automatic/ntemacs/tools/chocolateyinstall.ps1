$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$binPath               = "$toolsDir\emacs\bin"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url            = 'http://cha.la.coocan.jp/doc/../files/emacs-26.1-i686-minimum-ime.zip'
  checksum       = 'b3258655feec3770b367528ca5a92c28baff475657a3261f9fa1dd655a8dbc9d'
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
