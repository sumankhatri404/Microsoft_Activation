# Enable TLSv1.2 for compatibility with older clients
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12

$DownloadURL = 'https://raw.githubusercontent.com/sumankhatri404/Microsoft_Activation/main/1st/MAS_AIO.cmd'
$DownloadURL2 = 'https://raw.githubusercontent.com/sumankhatri404/Microsoft_Activation/main/2nd/MAS_AIO.cmd'

$FilePath = "$env:TEMP\MAS.cmd"
$ScriptArgs = "$args "

try {
    Invoke-WebRequest -Uri $DownloadURL -UseBasicParsing -OutFile $FilePath -ErrorAction Stop
} catch {
    try {
        Invoke-WebRequest -Uri $DownloadURL2 -UseBasicParsing -OutFile $FilePath -ErrorAction Stop
    } catch {
    Write-Error $_
  Return
}
}

if (Test-Path $FilePath) {
    Start-Process $FilePath $ScriptArgs -Wait
    $item = Get-Item -LiteralPath $FilePath
    $item.Delete()
}