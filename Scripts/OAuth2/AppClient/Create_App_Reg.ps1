Clear-Host;
$tenantId = $tenantId = (Get-AzContext).Tenant.Id;

$userReadId = "e1fe6dd8-ba31-4d61-89e7-88639da4683d";
$userReadAll = "df021288-bdef-4463-88db-98f22de89214";

$appName = "graphqlclient";

$replyUrls = @( "https://localhost:7474/signin-oidc" );
$replyUrls = @( "https://dummy");

$passwordCredentials = @(
    @{
        
    }
);

$webConfig = @{
    "ImplicitGrantSetting" = @{
        "EnableIdTokenIssuance" = $false
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

$clientApp = New-AzADApplication `
    -DisplayName $appName `
    -ReplyUrls $replyUrls `
    -SignInAudience AzureADMyOrg `
    -Web $webConfig `
    -PasswordCredentials $passwordCredentials `
    -RequiredResourceAccess $resourceAccess `
   ;

   $clientId = $clientApp.AppId;
   $clientSecret = $clientApp.PasswordCredentials[0].SecretText;
   
   Clear-Host;
   Write-Host "Application Registration: '$appName' Created";
   Write-Host "ClientId: $clientId";
   Write-Host "ClientSecret: $clientSecret";
   Write-Host "TenantId: $tenantId";

 
