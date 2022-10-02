Clear-Host;
$tenantId = $tenantId = (Get-AzContext).Tenant.Id;

$userReadId = "e1fe6dd8-ba31-4d61-89e7-88639da4683d";
$userReadAll = "df021288-bdef-4463-88db-98f22de89214";

$userAppName = "graphqluserclient";

$replyUrls = @( "https://localhost:7474/signin-oidc" );

$passwordCredentials = @(
    @{
        
    }
);

$webConfig = @{
    "ImplicitGrantSetting" = @{
        "EnableIdTokenIssuance" = $true
    }
};

$resourceAccess = @(
    @{
        "ResourceAccess" = @(
            @{
            "Id" = $userReadAll;
            "Type" = "Role";
            }
        );
        "ResourceAppId" = "00000003-0000-0000-c000-000000000000";
    }
);

$userClientApp = New-AzADApplication `
    -DisplayName $userAppName `
    -ReplyUrls $replyUrls `
    -SignInAudience AzureADMyOrg `
    -Web $webConfig `
    -PasswordCredentials $passwordCredentials `
    -RequiredResourceAccess $resourceAccess `
   ;

   $userClientId = $userClientApp.AppId;
   $userClientSecret = $userClientApp.PasswordCredentials[0].SecretText;
   
   Clear-Host;
   Write-Host "Application Registration: '$userAppName' Created";
   Write-Host "ClientId: $userClientId";
   Write-Host "ClientSecret: $userClientSecret";
   Write-Host "TenantId: $tenantId";

 
