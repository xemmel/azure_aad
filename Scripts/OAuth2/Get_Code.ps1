Clear-Host;
$scopes = "https://graph.microsoft.com/.default";
$scopes = "https://graph.microsoft.com/calendars.read";

#$scopes = "openid";

$url = "";
$url += "https://login.microsoftonline.com/$($tenantId)/oauth2/v2.0/authorize";
$url += "?client_id=$($clientId)";
$url += "&scope=$($scopes)";
$url += "&response_type=code";

$url;
$url | Set-Clipboard;
