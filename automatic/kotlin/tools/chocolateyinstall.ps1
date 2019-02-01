$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$binPath               = "$toolsDir\kotlinc\bin"

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url64bit       = 'https://github.com/JetBrains/kotlin/releases/download/v1.3.20/experimental-kotlin-compiler-windows-x64.zip'
  checksum64     = '88356e5f48acb279793f77173dd792eb46be5accabac0dd659763db6bf7c1b09'
  checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Install-BinFile "kotlin"         "$binPath\kotlin.bat"
Install-BinFile "kotlinc"        "$binPath\kotlinc.bat"
Install-BinFile "kotlinc-dce-js" "$binPath\kotlinc-dce-js.bat"
Install-BinFile "kotlinc-js"     "$binPath\kotlinc-js.bat"
Install-BinFile "kotlinc-jvm"    "$binPath\kotlinc-jvm.bat"
