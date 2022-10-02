Clear-Host;
$scopes = "https://servicebus.azure.net/.default";

$url = "https://login.microsoftonline.com/$tenantId";
$url += "/oauth2/v2.0/token";

$body = "";
$body += "client_id=$clientId";
$body += "&grant_type=client_credentials";
$body += "&client_secret=$clientSecret";
$body += "&scope=$scopes";




$response = $null;
$response = Invoke-WebRequest `
    -Uri $url `
    -Method Post `
    -Body $body;

## $response;
$token = $response.Content | ConvertFrom-Json | Select-Object -ExpandProperty access_token;
$token;
$token | Set-Clipboard;