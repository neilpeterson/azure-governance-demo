# Azure Container Instances

## Container Instance Naming Convention

```
# Values
RESOURCE_GROUP=myPolicyDemo
POLICY_NAME=aci-name
NAME_PATTERN=container##
POLICY=https://raw.githubu=sercontent.com/Azure-Samples/ignite-tour-lp4/master/LP4S4/policy-demo/aci-naming/azuredeploy.json?token=AHezGzaWkB4vdfUYBi5OmjRmjYXveqj6ks5cFqi6wA%3D%3D
PARAM=https://raw.githubusercontent.com/Azure-Samples/ignite-tour-lp4/master/LP4S4/policy-demo/aci-naming/azurepolicy.parameters.json?token=AHezG_SIFc_HSSIl0U4-wUkTk1ued5NAks5cFqjqwA%3D%3D

# Create  resource group
az group create --name $RESOURCE_GROUP --location eastus

# Get resource group id
$SCOPE=$(az group show --name $RESOURCE_GROUP --query id -o tsv)

# Create policy
az policy definition create --name $POLICY_NAME --display-name $POLICY_NAME --description $POLICY_NAME --rules $POLICY --params $PARAM --mode All

# Assign policy
az policy assignment create --scope $SCOPE --policy $POLICY_NAME -p '{"namePattern": {"value":"$NAME_PATTERN"}}'
```