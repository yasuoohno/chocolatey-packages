import-module au

$java    = '11'
$release = 'latest'
$arch    = 'x64'
$jvm     = 'hotspot'
$type    = 'jdk'

$latest_url = "https://api.adoptopenjdk.net/v2/info/releases/openjdk$java`?release=$release&os=windows&arch=$arch&openjdk_impl=$jvm&type=$type"


function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*\`$checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*\`$release\s*=\s*)('.*')" = "`$1'$($Latest.Release)'"
    }
    ".\tools\chocolateyuninstall.ps1" = @{
      "(?i)(^\s*\`$release\s*=\s*)('.*')" = "`$1'$($Latest.Release)'"
    }
  }
}

function global:au_GetLatest {
  Write-Host $latest_url
  $latest_info = Invoke-RestMethod -Uri $latest_url
  $url = $latest_info.binaries[0].binary_link
  Write-Host $url
  $release = $latest_info.binaries[0].version_data.openjdk_version
  $version = $release -split '\.|\+' | Select-Object -Skip 1
  $version = [int]$version[0]*10000 + [int]$version[1]*100 + [int]$version[2]

  @{
    URL64   = $url
    Version = "$java.$version"
    Release = $release
  }
}

update -ChecksumFor 64
