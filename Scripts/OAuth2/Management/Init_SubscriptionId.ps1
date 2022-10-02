Clear-Host;
$subscriptionId = az account show | 
                    ConvertFrom-Json |
                    Select-Object -ExpandProperty id;
$subscriptionId;