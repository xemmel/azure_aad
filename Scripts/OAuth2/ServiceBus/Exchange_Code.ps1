Clear-Host;
## Address
$address = Get-Clipboard;
$response = $address.Trim();

$parts = $response.Split('?');
$subpart = $parts[1].Split('&');
$code = $subpart[0].Substring(5);

$url = "https://login.microsoftonline.com/$($tenantId)/oauth2/token";

$body = "redirect_url=$($redirectUrl)&client_id=$($clientId)&grant_type=authorization_code&client_secret=$($clientSecret)&code=$($code)&redirect_uri=$($redirectUrl)";

$r = $null;
$r = Invoke-WebRequest -Method Post -Uri $url -Body $body -Headers @{ "Content-Type" = "application/x-www-form-urlencoded" };

$rr = $r.Content | ConvertFrom-Json;

$token = $rr.access_token;
$token | Set-Clipboard;
$token;