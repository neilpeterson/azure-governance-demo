RESOURCE_GROUP=myPolicyDemo
POLICY_NAME=myPolicyDemo
NAME_PATTERN=container##
RESOURCE_TYPE=Microsoft.ContainerInstance/containerGroups
POLICY=https://raw.githubusercontent.com/neilpeterson/talk-azure-governance-demo/master/policy/resource-name-by-type/azuredeploy.json
PARAM=https://raw.githubusercontent.com/neilpeterson/talk-azure-governance-demo/master/policy/resource-name-by-type/azurepolicy.parameters.json

# Create  resource group
az group create --name $RESOURCE_GROUP --location eastus

# Get resource group id
SCOPE=$(az group show --name $RESOURCE_GROUP --query id -o tsv)

# Create policy
az policy definition create --name $POLICY_NAME --display-name $POLICY_NAME --description $POLICY_NAME --rules $POLICY --params $PARAM --mode All

# Assign policy
az policy assignment create --display-name $POLICY_NAME --scope $SCOPE --policy $POLICY_NAME -p '{"namePattern": {"value":"'"$NAME_PATTERN"'"},"resourceType": {"value": "'"$RESOURCE_TYPE"'"}}'