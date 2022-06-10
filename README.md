## Azure AD (Microsoft Cloud Identity Provider)
## Integration-IT
## Morten la Cour

### Table of Content

1. [Introduction](#introduction)
2. [Web Apps](#web-apps)
3. [Get Tokens](#get-tokens)

4.  [CLI Commands](#cli-Commands)

## Introduction

[Back to top](#table-of-content)

## Web Apps

Create an **App Registration** in *AAD*
> See CLI Commands

### Modify Program.cs

```powershell

dotnet add package Microsoft.AspNetCore.Authentication.OpenIdConnect;
dotnet add package Microsoft.Identity.Web;
dotnet add package Microsoft.Identity.Web.UI;


```

> Program.cs

```csharp
using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.Identity.Web;
using Microsoft.Identity.Web.UI;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
    .AddMicrosoftIdentityWebApp(builder.Configuration.GetSection("AzureAd"));

builder.Services.AddAuthorization(options =>
{
    // By default, all incoming requests will be authorized according to the default policy.
    options.FallbackPolicy = options.DefaultPolicy;
});
builder.Services.AddRazorPages()
    .AddMicrosoftIdentityUI();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapRazorPages();
app.MapControllers();

app.Run();


```

> app.settings.json

```json

  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "Domain": "name.onmicrosoft.com",
    "TenantId": "a2...",
    "ClientId": "ff...",
    "CallbackPath": "/signin-oidc"
  }

```

> Shared/_LoginPartial.cshtml

```razor
@using System.Security.Principal

<ul class="navbar-nav">
@if (User.Identity?.IsAuthenticated == true)
{
        <span class="navbar-text text-dark">Hello @User.Identity?.Name!</span>
        <li class="nav-item">
            <a class="nav-link text-dark" asp-area="MicrosoftIdentity" asp-controller="Account" asp-action="SignOut">Sign out</a>
        </li>
}
else
{
        <li class="nav-item">
            <a class="nav-link text-dark" asp-area="MicrosoftIdentity" asp-controller="Account" asp-action="SignIn">Sign in</a>
        </li>
}
</ul>


```

> Shared/_Layout.cshtml

line 28

```razor
                    </ul>
                    <partial name="_LoginPartial" />
                </div>

```
[Back to top](#table-of-content)

## Get Tokens


### Init client

```powershell
### Anders And

$clientId = "38dd4f9a-4bde-4eda-a10b-7816dbada74e";
$clientSecret = "1rK8Q~JMaJu-NuxvyqB3j4btX72XSFeHuIqnEb-9";


## TestUser



$clientId = "aff9cacd-cdf1-48c4-b75f-ae2ab59c2dc3";
$clientSecret = "rbO7Q~8ugVvblbQG7P2fqvEQ0iReQb0SEHIFp";



```

### Get Token

```powershell

Clear-Host;

$tenantId = "a2ad8a68-fa4d-4208-987c-2328faa92b00";
$resourceUri = "https://management.azure.com/";
$resourceUri = "https://graph.microsoft.com/";

$url = "https://login.microsoftonline.com/$($tenantId)/oauth2/token";

$body = "grant_type=client_credentials&client_id=$($clientId)&client_secret=$($clientSecret)&resource=$($resourceUri)";

$response = $null;
$response = Invoke-WebRequest -Uri $url -Method Post -Body $body;
$response.Content | ConvertFrom-Json | Select-Object -ExpandProperty access_token;
$response.Content | ConvertFrom-Json | Select-Object -ExpandProperty access_token | Set-Clipboard;
$token = $response.Content | ConvertFrom-Json | Select-Object -ExpandProperty access_token;

$headers = @{"Authorization" = "Bearer $token"};

$parts = $token.Split('.');
if (($parts[1].Length % 4) -ne 0) {
    if (($parts[1].Length % 4) -eq 1) {
        $parts[1] += "===";
    }
        if (($parts[1].Length % 4) -eq 2) {
        $parts[1] += "==";
    }
            if (($parts[1].Length % 4) -eq 3) {
        $parts[1] += "=";
    }
}

[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($parts[0])) | ConvertFrom-Json | ConvertTo-Json;
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($parts[1])) | ConvertFrom-Json | ConvertTo-Json;


```

### Test Management 

```powershell


### Test management
Clear-Host;
$subscriptionId = "0617cd7e-3534-470e-8afe-8c58072eb52c";

$url = "https://management.azure.com/subscriptions/$($subscriptionId)/resourceGroups?api-version=2020-06-01";

$response = $null;
$response = Invoke-WebRequest -Uri $url -Method Get -Headers $headers;
$response.Content | ConvertFrom-Json | ConvertTo-Json;





```

### Test Graph (AAD)


```powershell

### Test AAD (Graph)
Clear-Host;
$url = "https://graph.microsoft.com/v1.0/users";

$response = $null;
$response = Invoke-WebRequest -Uri $url -Method Get -Headers $headers;
$response.Content | ConvertFrom-Json | ConvertTo-Json;

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

$displayName = "thefullwebapp";
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
$redirectUrl = "https://localhost:7283";
$type = "web"; ## spa|publicClient

$url = "https://graph.microsoft.com/v1.0/applications/$appObjectId";
$token = az account get-access-token --resource "https://graph.microsoft.com/" | ConvertFrom-Json | Select-Object -ExpandProperty accessToken;

$body = @"
{
    "$($type)" : {
        "redirectUris" : [ "$($redirectUrl)/","$($redirectUrl)/signin-oidc" ],
        "logoutUrl" : "$($redirectUrl)/signout-oidc",
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
