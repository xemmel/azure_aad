## UNLOCK
Clear-Host;
$requestUrl = "$queueUrl/messages/$messageId/$lockToken";
Invoke-WebRequest -Method Put `
 -Uri $requestUrl `
 -Headers $headers;


 ##  DELETE
Clear-Host;
$requestUrl = "$queueUrl/messages/$messageId/$lockToken";
Invoke-WebRequest -Method Delete `
 -Uri $requestUrl `
 -Headers $headers;