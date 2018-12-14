<#
 .DESCRIPTION
    Creates Azure BluePrint
 .NOTES
    Author: Neil Peterson
    Intent: Sample to demonstrate Azure BluePrints with Azure DevOps
 #>

param (
   [string]$ManagetGroup = 'nepeters-internal',
   [string]$BlueprintName = 'DevOpsBluePrint',
   [string]$Vault = 'nepeterskv007',
   [string]$Blueprint = 'blueprint-body.json',
   [string]$TenantId,
   [string]$ClientId,
   [string]$ClientSecret,
   [string]$SubscriptionId
 )

# Get Auth values from KeyVault
# $TenantId = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureTenantID).SecretValueText
# $ClientId = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureClientID).SecretValueText
# $ClientSecret = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureClientSecret).SecretValueText
# $SubscriptionId = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureSubscriptionID).SecretValueText

# Acquire an access token
$Resource = "https://management.core.windows.net/"
$RequestAccessTokenUri = 'https://login.microsoftonline.com/{0}/oauth2/token' -f $TenantId
$body = "grant_type=client_credentials&client_id={0}&client_secret={1}&resource={2}" -f $ClientId, $ClientSecret, $Resource
$Token = Invoke-RestMethod -Method Post -Uri $RequestAccessTokenUri -Body $body -ContentType 'application/x-www-form-urlencoded'

# Create BluePrint
$Headers = @{}
$Headers.Add("Authorization","$($Token.token_type) "+ " " + "$($Token.access_token)")
$BPCreateUpdate = 'https://management.azure.com/providers/Microsoft.Management/managementGroups/{0}/providers/Microsoft.Blueprint/blueprints/{1}?api-version=2017-11-11-preview' -f $ManagetGroup, $BlueprintName
$body = Get-Content -Raw -Path $Blueprint
Invoke-RestMethod -Method PUT -Uri $BPCreateUpdate -Headers $Headers -Body $body -ContentType "application/json"

# Get Published BP / Last version number
# Can use this if I want to sequence versions numbers
# $Get = "https://management.azure.com/providers/Microsoft.Management/managementGroups/{0}/providers/Microsoft.Blueprint/blueprints/{1}/versions?api-version=2017-11-11-preview" -f $ManagetGroup, $BlueprintName
# $pubBP = Invoke-RestMethod -Method GET -Uri $Get -Headers $Headers
# write-host $pubBP.value[$pubBP.value.Count - 1].name

# Publish Blueprint with random version number
$version = get-random
$Publish = "https://management.azure.com/providers/Microsoft.Management/managementGroups/{0}/providers/Microsoft.Blueprint/blueprints/{1}/versions/{2}?api-version=2017-11-11-preview" -f $ManagetGroup, $BlueprintName, $version
Invoke-RestMethod -Method PUT -Uri $Publish -Headers $Headers