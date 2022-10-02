Clear-Host;
$token = Get-Clipboard;
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


