import-module au

$latest_url = 'https://github.com/JetBrains/kotlin/releases/latest'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url64bit\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $latest_url
  $url = $download_page.Links | ? href -match '-windows-x64\.zip$' | % href | select -First 1
  $url = 'https://github.com' + $url
  $version = $url -split '/' | select -Last 1 -Skip 1
  if ( $version -match "v(?<version>.*?)$") {
    $version = $Matches.version
  }

  @{
    URL64 = $url
    Version = $version
  }
}

update -ChecksumFor 64
