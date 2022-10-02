Clear-Host;
$tenantId = $tenantId = (Get-AzContext).Tenant.Id;

$displayName = "graphqlclient";
$clientApp = Get-AzADApplication -DisplayName $displayName;
$clientId = $clientApp.AppId;
Write-Host "ClientAppId: $clientId";
$clientSp = Get-AzADServicePrincipal -ApplicationId $clientId;
$clientSpId = $clientSp.Id;
Write-Host "Service Principal Id: $clientSpId";



