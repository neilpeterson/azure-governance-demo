# Azure Container Instances

## Container Instance Naming Convention

```
# Values
RESOURCE_GROUP=myPolicyDemo
POLICY_NAME=aci-name
NAME_PATTERN=container##
POLICY=https://raw.githubusercontent.com/neilpeterson/azure-governance-demo/master/policy/container-instances/azuredeploy.json
PARAM=https://raw.githubusercontent.com/neilpeterson/azure-governance-demo/master/policy/container-instances/azurepolicy.parameters.json

# Create  resource group
az group create --name $RESOURCE_GROUP --location eastus

# Get resource group id
$SCOPE=$(az group show --name $RESOURCE_GROUP --query id -o tsv)

# Create policy
az policy definition create --name $POLICY_NAME --display-name $POLICY_NAME --description $POLICY_NAME --rules $POLICY --params $PARAM --mode All

# Assign policy
az policy assignment create --scope $SCOPE --policy $POLICY_NAME -p '{"namePattern": {"value":"$NAME_PATTERN"}}'
```