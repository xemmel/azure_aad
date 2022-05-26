## Azure AD (Microsoft Cloud Identity Provider)
## Integration-IT
## Morten la Cour

### Table of Content

1. [Introduction](#introduction)
2. [Web Apps](#web-apps)

10. [CLI Commands](#cli-Commands)

## Introduction

[Back to top](#table-of-content)

## Web Apps

Create an **App Registration** in *AAD*
```powershell

```

[Back to top](#table-of-content)

## CLI Commands

#### List all App Registrations

```powershell
Clear-Host;
az ad app list --query "[].{displayName:displayName,appId:appId}" -o table
```
#### Get Application(s) from DisplayName

```powershell
Clear-Host;
$displayName = "thenewapp";

$query = "[].{displayName:displayName,appId:appId}";
az ad app list --display-name $displayName --query $query -o table;

```

#### Get App Registration

```powershell
# $appId = "c57425aa-8299-4c27-ba62-4176e028d82b";

Clear-Host;

$query = "{name:displayName,appId:appId,id:id,aud:signInAudience,publisherDomain:publisherDomain,requiredResourceAccess:requiredResourceAccess,web:web}"
az ad app show --id $appId `
    -o jsonc `
    --query $query;

## All
Clear-Host;
az ad app show --id $appId `
    -o jsonc;

```

#### Create App Registration (Clean)

```powershell
Clear-Host;
#$aud = "AzureADandPersonalMicrosoftAccount";
#$aud = "AzureADMultipleOrgs";
$aud = "AzureADMyOrg";

$displayName = "bestilmereweb";
$result = az ad app create --display-name $displayName --sign-in-audience $aud;
$app = $result | ConvertFrom-Json;
Write-Host "ClientId: $($app.AppId)";
Write-Host "Id: $($app.id)";
$appId = $app.AppId;
$appObjectId = $app.id;

```
### Add RedirectUrls

```powershell
# $appId = "3b568264-c6ac-40b0-95df-b5845cb8f475";
# $appObjectId = "84be8977-721d-4f7d-95f3-0f0926b993cb";

Clear-Host;
$redirectUrl = "https://localhost:7035";
$type = "web"; ## spa|publicClient

$url = "https://graph.microsoft.com/v1.0/applications/$appObjectId";
$token = az account get-access-token --resource "https://graph.microsoft.com/" | ConvertFrom-Json | Select-Object -ExpandProperty accessToken;

$body = @"
{
    "$($type)" : {
        "redirectUris" : [ "$($redirectUrl)/","$($redirectUrl)/signin-oidc" ],
        "logoutUrl" : "$($redirectUrl)/signout-callback-oidc",
        "implicitGrantSettings" : {
            "enableAccessTokenIssuance": false,
            "enableIdTokenIssuance": true
        }
    }
}
"@

$response = $null;
$response = Invoke-webrequest -uri $url -method patch `
    -body $body -headers @{"Authorization" = "Bearer $token"; "Content-Type" = "application/json" };
$response;


```

#### Remove App Resigration

```powershell
# $appId = "c57425aa-8299-4c27-ba62-4176e028d82b";

Clear-Host;
az ad app delete --id $appId;

```

[Back to top](#table-of-content)
