Clear-Host;
$token = az account get-access-token |
            ConvertFrom-Json | 
            Select-Object -ExpandProperty accessToken;

$token;
$token | Set-Clipboard;