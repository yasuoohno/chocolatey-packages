$ErrorActionPreference = 'Stop'
$packageName           = "$env:ChocolateyPackageName"

Uninstall-BinFile "kotlin"
Uninstall-BinFile "kotlinc"
Uninstall-BinFile "kotlinc-dce-js"
Uninstall-BinFile "kotlinc-js"
Uninstall-BinFile "kotlinc-jvm"
