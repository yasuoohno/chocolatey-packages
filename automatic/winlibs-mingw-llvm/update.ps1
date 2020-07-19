import-module au

$latest_url = 'https://github.com/brechtsanders/winlibs_mingw/releases/latest'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url64bit\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $latest_url
  $url = $download_page.Links | ? href -match 'winlibs-x86_64-posix-seh-gcc-[\d.]+-llvm-[\d.]+-mingw-w64-[\d.]+-r[\d]+\.7z$' | % href | select -First 1
  $url = 'https://github.com' + $url
  $fn = $url -split '/' | select -Last 1
  $release = $fn -split '-' | select -Skip 11 -First 1
  $release = $release -replace 'r([\d]+)\.7z$','$1'
  $version = $fn -split '-' | select -Skip 5 -First 1

  @{
    URL = $url
    Version = $version + '.' + $release
  }
}

update -ChecksumFor 64
