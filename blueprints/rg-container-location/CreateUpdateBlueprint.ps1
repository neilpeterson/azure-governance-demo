<#
 .DESCRIPTION
    Creates Azure BluePrint
 .NOTES
    Author: Neil Peterson
    Intent: Sample to demonstrate Azure BluePrints with Azure DevOps
 #>

# Management group, Blueprint name, and BP Endoints
$ManagetGroup="nepeters-internal"
$Blueprint="DevOpsBluePrint"
$BPBase = "https://management.azure.com/providers/Microsoft.Management/managementGroups/"
$BPApiVersion = "?api-version=2017-11-11-preview"
$BPCreateUpdate = "$BPBAse$ManagetGroup/providers/Microsoft.Blueprint/blueprints/$Blueprint$BPApiVersion"

 # Key Vault Name
$Vault = "nepeterskv007"

# Get Auth values from KeyVault
$TenantId = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureTenantID).SecretValueText
$ClientId = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureClientID).SecretValueText
$ClientSecret = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureClientSecret).SecretValueText
$SubscriptionId = (Get-AzKeyVaultSecret -VaultName $Vault -Name AzureSubscriptionID).SecretValueText

# Acquire an access token
$Resource = "https://management.core.windows.net/"
$RequestAccessTokenUri = "https://login.microsoftonline.com/$TenantId/oauth2/token"
$body = "grant_type=client_credentials&client_id=$ClientId&client_secret=$ClientSecret&resource=$Resource"
$Token = Invoke-RestMethod -Method Post -Uri $RequestAccessTokenUri -Body $body -ContentType 'application/x-www-form-urlencoded'

# Create BluePrint
$Headers = @{}
$Headers.Add("Authorization","$($Token.token_type) "+ " " + "$($Token.access_token)")
$body = Get-Content -Raw -Path ./rg-body.json
Invoke-RestMethod -Method PUT -Uri $BpAPI -Headers $Headers -Body $body -ContentType "application/json" | ConvertTo-Json