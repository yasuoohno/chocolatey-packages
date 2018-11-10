$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$binPath               = "$toolsDir\kotlinc\bin"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url64bit       = 'https://github.com/JetBrains/kotlin/releases/download/v1.3.0/kotlin-compiler-1.3.0-release-windows-x64.zip'
  checksum64     = '82d896cfa6c53eb2c2475c9683058e078af1fa07ec092e8f40bcccec194d0caa'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-BinFile "kotlin"         "$binPath\kotlin.bat"
Install-BinFile "kotlinc"        "$binPath\kotlinc.bat"
Install-BinFile "kotlinc-dce-js" "$binPath\kotlinc-dce-js.bat"
Install-BinFile "kotlinc-js"     "$binPath\kotlinc-js.bat"
Install-BinFile "kotlinc-jvm"    "$binPath\kotlinc-jvm.bat"
