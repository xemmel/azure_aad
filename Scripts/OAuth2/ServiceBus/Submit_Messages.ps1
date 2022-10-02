Clear-Host;

$queueUrl = "https://$sbNamespace.servicebus.windows.net/$queueName";
$requestUrl = "$queueUrl/messages";

$response = $null;


$headers = @{ "Authorization" = "Bearer $token" };

for($i = 0; $i -lt 5; $i++)
{
$body = "Morten $i";

Invoke-WebRequest -Method Post `
 -Body $body `
 -Uri $requestUrl `
 -Headers $headers;

 }


Clear-Host;

$queueUrl = "https://integrationitbasic.servicebus.windows.net/theshortqueue";
$requestUrl = "$queueUrl/messages";

$response = $null;


$headers = @{ 
    "Authorization" = "Bearer $token";
    "Content-Type" = "application/vnd.microsoft.servicebus.json" };



$body = @"
[
{
  "Body" : "Morten 1",
  "BrokerProperties" : { "Label" : "L1" },
  "UserProperties" : { "TheName" : "1" }
},
{
  "Body" : "Morten 2",
  "BrokerProperties" : { "Label" : "L2" },
  "UserProperties" : { "TheName" : "2" }
}
]
"@;


Invoke-WebRequest -Method Post `
 -Body $body `
 -Uri $requestUrl `
 -Headers $headers;

