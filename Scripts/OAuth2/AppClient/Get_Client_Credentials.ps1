Clear-Host;

$scopes = "https://graph.microsoft.com/.default";

$url = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token";

$body = "";
$body += "grant_type=client_credentials";
$body += "&client_id=$clientId";
$body += "&client_secret=$clientSecret";
$body += "&scope=$scopes";





$response = $null;
$response = Invoke-WebRequest `
        -Uri $url `
        -Method Post `
        -Body $body;

$response.Content;
$token = $response.Content | 
    ConvertFrom-Json | 
    Select-Object -ExpandProperty access_token;
## $token;
$token | Set-Clipboard;
