$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$binPath               = "$toolsDir\kotlinc\bin"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url64bit       = ''
  checksum64     = ''
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-BinFile "kotlin"         "$binPath\kotlin.bat"
Install-BinFile "kotlinc"        "$binPath\kotlinc.bat"
Install-BinFile "kotlinc-dce-js" "$binPath\kotlinc-dce-js.bat"
Install-BinFile "kotlinc-js"     "$binPath\kotlinc-js.bat"
Install-BinFile "kotlinc-jvm"    "$binPath\kotlinc-jvm.bat"
