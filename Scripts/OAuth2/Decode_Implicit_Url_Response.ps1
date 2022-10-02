Clear-Host;



## $responseUrl = Read-Host('responseUrl');
Clear-Host;
$outerParts = $responseUrl.Split('#');
$tokenPart = $outerParts[1];

$parts = $tokenPart.Split('&');

foreach($part in $parts)
{
   # Write-Host $part;
    $subParts = $part.Split('=');
  if (($subParts[0] -eq "access_token") -or ($subParts[0] -eq "id_token"))
  {
    Write-Host $subParts[0];
    Write-Host;
    $token = $subParts[1];

    $p = $token.Split('.');
$parts = $p[0];
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



$p = $token.Split('.');
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



  }
}






