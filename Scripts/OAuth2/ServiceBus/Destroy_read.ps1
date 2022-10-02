Clear-Host;

$queueUrl = "https://$sbNamespace.servicebus.windows.net/$queueName";
$requestUrl = "$queueUrl/messages/head";


$response = $null;


$headers = @{ "Authorization" = "Bearer $token" };

$response = Invoke-WebRequest -Method Delete `
 -Uri $requestUrl `
 -Headers $headers;


## [System.Text.Encoding]::UTF8.GetString($response.Content);
$response.Content;

$propertyHeaders = $response.Headers.BrokerProperties | ConvertFrom-Json;
$propertyHeaders;
$lockToken =  $propertyHeaders.LockToken;
$lockToken;
$messageId =  $propertyHeaders.MessageId;
$messageId;
$sequenceNumber =  $propertyHeaders.SequenceNumber;
$sequenceNumber;