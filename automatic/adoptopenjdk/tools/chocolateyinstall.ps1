Add-Type -AssemblyName System.Web

function Get-RedirectedUrl
{
    Param (
        [Parameter(Mandatory=$true)]
        [String]$URL
    )

    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()

    If ($response.StatusCode -eq "Found")
    {
        $response.GetResponseHeader("Location")
    }
}

$java       = '11'
$jvm        = 'hotspot'
$arch       = 'x64'
$release    = '11.0.2+9'
$type       = 'jdk'
$releaseURL = $type + '-' + [System.Web.HttpUtility]::UrlEncode($release)

$apiurl= "https://api.adoptopenjdk.net/v2/binary/releases/openjdk$java`?os=windows&openjdk_impl=$jvm&arch=$arch&release=$releaseURL&type=$type"

$packageName = $env:ChocolateyPackageName
$targetDir   = 'C:\Program Files\AdoptOpenJDK'
$url64       = Get-RedirectedUrl $apiurl
$checksum64  = 'bde1648333abaf49c7175c9ee8ba9115a55fc160838ff5091f07d10c4bb50b3a'
 
Install-ChocolateyZipPackage $packageName $url64 $targetDir
Install-ChocolateyEnvironmentVariable 'JAVA_HOME' $targetDir\$type-$release 'Machine'
# The full path instead of the %JAVA_HOME% is needed so it can be removed with the Chocolatey Uninstall
Install-ChocolateyPath "$targetDir\$type-$release\bin" -PathType 'Machine'
