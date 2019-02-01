import-module au

$latest_url = 'http://cha.la.coocan.jp/doc/NTEmacs.html'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $latest_url
  $url = $download_page.Links | ? href -match 'emacs-[\d.]+-[^.]*\.zip$' | % href | select -First 1
  $url = 'http://cha.la.coocan.jp/doc/' + $url
  $version = $url -split '/' | select -Last 1
  if ( $version -match "emacs-(?<version>[\d.]+?)-[^.]*\.zip$") {
    $version = $Matches.version
  }

  @{
    URL32 = $url
    Version = $version
  }
}

update -ChecksumFor 32
