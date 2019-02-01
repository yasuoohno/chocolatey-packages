$targetDir    = 'C:\Program Files\AdoptOpenJDK'
$release      = '11.0.2+9'
$type         = 'jdk'

$uninstallDir = "$targetDir\$type-$release"
$removePath   = "$targetDir\$type-$release\bin"
$pathType     = 'Machine'

Uninstall-ChocolateyEnvironmentVariable 'JAVA_HOME' 'Machine'
Remove-Item -r $uninstallDir

# remove from PATH.
if ($env:PATH.ToLower().Contains($removePath.ToLower()))
{
  $statementTerminator = ";"
  Write-Host "PATH environment variable contains $removePath. Removing..."
  $actualPath = [System.Collections.ArrayList](Get-EnvironmentVariable -Name 'Path' -Scope $pathType).split($statementTerminator)
 
  $actualPath.Remove($removePath)
  $newPath =  $actualPath -Join $statementTerminator
 
  if ($pathType -eq [System.EnvironmentVariableTarget]::Machine) {
    if (Test-ProcessAdminRights) {
      Set-EnvironmentVariable -Name 'Path' -Value $newPath -Scope $pathType
    } else {
      $psArgs = "UnInstall-ChocolateyPath -pathToUnInstall `'$originalPathToUnInstall`' -pathType `'$pathType`'"
      Start-ChocolateyProcessAsAdmin "$psArgs"
    }
  } else {
    Set-EnvironmentVariable -Name 'Path' -Value $newPath -Scope $pathType
  }
}

# if there should be no other versions, remove targetDir.
If ((Get-ChildItem -Force $targetDir) -eq $Null) {
    Remove-Item $targetDir
}
