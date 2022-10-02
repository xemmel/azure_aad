Clear-Host;
$addressResponse = @"
https://localhost:7777/signin-oidc#id_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjJaUXBKM1VwYmpBWVhZR2FYRUpsOGxWMFRPSSJ9.eyJhdWQiOiJlMGU0ZTVkMC0wOGI2LTQ2MGYtYWU0My00M2Q1YjkyOWZlYmQiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vYTJhZDhhNjgtZmE0ZC00MjA4LTk4N2MtMjMyOGZhYTkyYjAwL3YyLjAiLCJpYXQiOjE2NTYwMDg5NzksIm5iZiI6MTY1NjAwODk3OSwiZXhwIjoxNjU2MDEyODc5LCJhaW8iOiJBYlFBUy84VEFBQUF6bWhpWEF3OGhobWdQK3lpQ2Y0VFA1ZzN5UjY4U2VsR0tCRCtDMmlMRTlKd1plWmFIRWtZT003SWp6TDRGS1ZKdlJ6eEVZZy9UNVJ6R1ZVajBDUzk3T0RTYWFEUW5DNFpMK20vWXpXeGJiZ1dZaG5PSTVFL2VsbE55cFgrMUNwTzVtV20vbHJjSGoxMkhaTWFUb3MrS1RoajhCVFM4aktRY3NaZHFoS01CdGRmNG50MWlxSFd6SUpmem9HQ2lKZ2w0TU5yVzhmQ05tVVkwNlFqSEttTkpwYmNwTmF5RlR5aWNYdHl4NUpHS2JNPSIsImlkcCI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzkxODgwNDBkLTZjNjctNGM1Yi1iMTEyLTM2YTMwNGI2NmRhZC8iLCJuYW1lIjoiTW9ydGVuIGxhY291ciIsIm5vbmNlIjoiNjc4OTEwIiwib2lkIjoiNDI0YzUyM2ItYzQ1Mi00MTNiLTk5ZTUtMDQwZmIxNDYzYjg3IiwicHJlZmVycmVkX3VzZXJuYW1lIjoibGFjb3VyQGdtYWlsLmNvbSIsInByb3ZfZGF0YSI6W3siYXQiOnRydWUsInByb3YiOiJnaXRodWIuY29tIiwiYWx0c2VjaWQiOiI4MTUwMDc2In1dLCJyaCI6IjAuQVM4QWFJcXRvazM2Q0VLWWZDTW8tcWtyQU5EbDVPQzJDQTlHcmtORDFia3BfcjB2QUhFLiIsInN1YiI6IlB5VlI2ckZJYWxVRV94a0t5a3J5ZEZHdi1CNFZIdHZSTFRGUEFCLWlKM1kiLCJ0aWQiOiJhMmFkOGE2OC1mYTRkLTQyMDgtOTg3Yy0yMzI4ZmFhOTJiMDAiLCJ1dGkiOiI2bDlqNktyWVRrS1VFR085YjlBWEFBIiwidmVyIjoiMi4wIn0.tI4lvu44hqHh7ODINqnDr4Nu2Ne-Vv7GMCoB_MviB7_57yxjGBdy0kzuqb2ckYjI2eWI-iEz1j_a8YKT5OpgJyVul4yJk0preOP9-jr2_V0Ah6vwxlfDHhIsTGr-L332fmuF62FExY-ei0c2csRlloKuHtWfUXs2jTEVjcGD-MspPyIenzcTcvMjqPlTAZHFCaWL7YjnMGJUz1uZeCOxpSrTFxbrGmSbXjP5xkH1h503Jlw2HD5REaRnwRSkwJp62tXXpCyNYjcUrsKCi1NELH4Q0UsJzJ72aupC3wN7CnkXFx5D3yHs5ClAzXj4QBxHF9uZSlsNVHq8VZm_w0fRAA&session_state=80e7234e-0a1f-486c-8bc0-9b02587c5f91
"@


## $addressResponse = Read-Host('response');
$addressResponse = $addressResponse.Trim();
## $addressResponse = $code;
$parts = $addressResponse.Split('?');
$subpart = $parts[1].Split('&');
$code = $subpart[0].Substring(5);

$url = "https://login.microsoftonline.com/$($tenantId)/oauth2/token";

$body = "redirect_url=$($redirectUrl)&client_id=$($clientId)&grant_type=authorization_code&client_secret=$($clientSecret)&code=$($code)";

# $body;
$r = $null;
$r = Invoke-WebRequest -Method Post -Uri $url -Body $body -Headers @{ "Content-Type" = "application/x-www-form-urlencoded" };

# $r.Content | ConvertFrom-Json | ConvertTo-Json;

$accessToken = $r.Content | ConvertFrom-Json | Select-Object -ExpandProperty access_token;
$idToken = $r.Content | ConvertFrom-Json | Select-Object -ExpandProperty id_token;

$accessToken | Set-Clipboard

# Clear-Host;
$p = $accessToken.Split('.');
$parts = $p[1];
if (($parts.Length % 4) -ne 0) {
    if (($parts.Length % 4) -eq 1) {
        $parts += "===";
    }
        if (($parts.Length % 4) -eq 2) {
        $parts += "==";
    }
            if (($parts.Length % 4) -eq 3) {
        $parts += "=";
    }
}



[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($parts)) | ConvertFrom-Json | ConvertTo-Json;


$p = $idToken.Split('.');
$parts = $p[1];
if (($parts.Length % 4) -ne 0) {
    if (($parts.Length % 4) -eq 1) {
        $parts += "===";
    }
        if (($parts.Length % 4) -eq 2) {
        $parts += "==";
    }
            if (($parts.Length % 4) -eq 3) {
        $parts += "=";
    }
}

[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($parts)) | ConvertFrom-Json | ConvertTo-Json;
