import-module au

$latest_url = 'https://hp.vector.co.jp/authors/VA024651/PuTTYkj.html'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $latest_url
  $url = $download_page.Links | ? href -match 'putty-[\d.]+-jp[\d]+\.zip$' | % href | select -First 1
  $version = $url -split '-' | select -Last 1 -Skip 1
  if ( $version -match "v(?<version>.*?)$") {
    $version = $Matches.version
  }

  @{
    URL = $url
    Version = $version
  }
}

update -ChecksumFor 32
