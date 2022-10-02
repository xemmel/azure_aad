Clear-Host;
$response = Get-Clipboard;

$parts = $response.Split('#');
$lowerPart = $parts[1];
# $lowerPart;
$innerParts = $lowerPart.Split('&');
$token = $innerParts[0].Split('=')[1];
$token;
$token | Set-Clipboard;