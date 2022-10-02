Clear-Host;

$url = "https://login.microsoftonline.com/$tenantId/v2.0/.well-known/openid-configuration";

$response = $null;
$response = Invoke-WebRequest -Uri $url -Method Get;

$r = $response.Content |
    ConvertFrom-Json |
    ConvertTo-Json -Depth 10;
$r;
$r | Set-Clipboard;

