<#
 .DESCRIPTION
    Assign Azure BluePrint
 .NOTES
    Author: Neil Peterson
    Intent: Sample to demonstrate Azure BluePrints with Azure DevOps
 #>

 # Key Vault Name
 $Vault = "nepeterskv007"

 # Get Auth values from KeyVault
 $TenantId = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureTenantID).SecretValueText
 $ClientId = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureClientID).SecretValueText
 $ClientSecret = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureClientSecret).SecretValueText
 $SubscriptionId = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureSubscriptionID).SecretValueText

# Management group, Blueprint name, and BP Endoints
$ManagetGroup='nepeters-internal'
$BlueprintName='DevOpsBluePrint'
$BPBase = 'https://management.azure.com/subscriptions/'
$BPApiVersion = '?api-version=2017-11-11-preview'
$BPAssign = '{0}/providers/Microsoft.Blueprint/blueprintAssignments/{1}{2}' -f $SubscriptionId, $BlueprintName, $BPApiVersion

# Blueprint definition file
$Blueprint = "assign-blueprint-body.json"

# Acquire an access token
$Resource = 'https://management.core.windows.net/'
$RequestAccessTokenUri = 'https://login.microsoftonline.com/{0}/oauth2/token' -f $TenantId
$body = 'grant_type=client_credentials&client_id={0}&client_secret={1}&resource={2}' -f $ClientId, $ClientSecret, $Resource
$Token = Invoke-RestMethod -Method Post -Uri $RequestAccessTokenUri -Body $body -ContentType 'application/x-www-form-urlencoded'

# Create BluePrint
$Headers = @{}
$Headers.Add("Authorization","$($Token.token_type) "+ " " + "$($Token.access_token)")
$body = Get-Content -Raw -Path $Blueprint | ConvertFrom-Json
$body.properties.blueprintId = "{/providers/Microsoft.Management/managementGroups/{0}/providers/Microsoft.Blueprint/blueprints/{1}" -f $ManagetGroup, $BlueprintName
Invoke-RestMethod -Method PUT -Uri $BPAssign -Headers $Headers -Body $body -ContentType "application/json"