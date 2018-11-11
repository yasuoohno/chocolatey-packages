import-module au

$latest_url = 'https://github.com/luapower/luapower-all/releases'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*\`$binPath\s*=\s*)(`".*`")" = "`$1`"`$toolsDir\luapower-all-$($Latest.VersionRaw)\`""
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $latest_url
  $url = $download_page.Links | ? href -match '/[\d-]+.zip$' | % href | select -First 1
  $url = 'https://github.com' + $url
  $version = $url -split '/' | select -Last 1
  if ( $version -match "(?<version>[\d-]+?)\.zip$") {
    $versionraw = $Matches.version
    $version = $versionraw.replace('-', '.')
  }

  @{
    URL = $url
    Version = $version
    VersionRaw = $versionraw
  }
}

update -ChecksumFor 32
