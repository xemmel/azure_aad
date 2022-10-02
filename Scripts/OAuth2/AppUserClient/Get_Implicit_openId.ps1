Clear-Host;

$scopes = "openid profile"

$url = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/authorize";

$url += "?client_id=$userClientId";
$url += "&scope=$scopes";
$url += "&response_type=id_token"
$url += "&nonce=678910"

$url | Set-Clipboard;

