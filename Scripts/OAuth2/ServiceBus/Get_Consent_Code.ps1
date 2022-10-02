Clear-Host;
$scopes = "https://servicebus.azure.net/user_impersonation";

$redirectUrl = "https://localhost/myapp/";

$url = "https://login.microsoftonline.com/$tenantId";
$url += "/oauth2/v2.0/authorize";


$url += "?client_id=$clientId";
$url += "&redirect_uri=$redirectUrl";
$url += "&response_mode=query";
$url += "&response_type=code";
$url += "&scope=$scopes";


$url | Set-Clipboard;