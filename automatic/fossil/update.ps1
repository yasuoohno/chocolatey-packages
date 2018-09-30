import-module au

$juvlist_api = 'https://fossil-scm.org/index.html/juvlist'
$download_url = 'https://www.fossil-scm.org/xfer/uv/'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
  $juv = Invoke-WebRequest -Uri $juvlist_api | ConvertFrom-Json
  $latest = $juv | Where-Object {$_.name -like 'fossil-w32-*.zip'} | Sort-Object -Descending -Property mtime | Select-Object -First 1
  if ( $latest -notmatch "fossil-w32-(?<version>.*?)\.zip" ) {
  }

  $version = $Matches.version
  $url = $download_url + $latest.name
  $original_hash = $latest.hash

  @{
    URL32 = $url
    Version = $version
    OriginalHash = $original_hash
  }
}

update -ChecksumFor 32
