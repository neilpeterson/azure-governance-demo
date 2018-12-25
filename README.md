## Azure RBAC:

**Portal intro to RBAC**

- Show subscription and established roles (1 owner, 1 reader)
- Log in as reader and attempt to create something
- Update reader to Restart VM (custom role) and show result

**Automation**

Create custom role with Azure CLI, two samples in the repo:

- [Read / Write Container Instances](./rbac/container-instances-all.json)
- [Restart Virtual Machines](./rbac/vm-restart.json)

**Read / Write Container Instances:**

```
az role definition create --role-definition container-instances-all.json
```

Assign custom role with Azure CLI

```
az role assignment create --role "Container Instances Read / Write" --assignee rebecca@nepeters.com
```

## Azure Policy

**Portal intro to Policy**

Manually create policy (audit resource group location) to demo portal and built in policy.

**Automation**

Create policy with Azure CLI, three sample in the repo:

- [Deny: Enforce naming by resource type](./policy/name-by-type/azuredeploy.json)
- [Deny: Enforce resource tag](./policy/tag-deny/azuredeploy.json)
- [Append: resource tag](./policy/tag-append/azuredeploy.json)

**Deny: Enforce naming by resource type**

```
sh ./policyEnforceName.sh
```

**Deny: Enforce resource tag**

```
sh ./policyTagDeny.sh
```

**Append: resource tag**

```
sh ./policyTagAppend.sh
```

**Initiative:**

TODO - add CLI example for initiative.

## Azure Blueprints

**Manual Demo**

Create blueprint consisting of two of the above policies, and resource group, and Resource Manager template.

**Automation**

Currently no PowerShell or CLI support for Blueprints. I've included PowerShell scripts to demo the REST interface, they are rough. I've also configured a Azure DevOps pipeline to demonstrate CI/CD. If you would like access, let me know.

- [Blueprint](./blueprints/create-blueprint/blueprint-body.json)
- [Create Blueprint](./blueprints/create-blueprint/CreateUpdateBlueprint.ps1)
- [Assign Blueprint](./blueprints/assign-blueprint/AssignBlueprint.ps1)

**Rest Demo**

Create and Publish:

```
pwsh ./CreateUpdateBlueprint.ps1
```

Assign:

```
pwsh ./AssignBlueprint.ps1
```

**Azure DevOps and Blueprints**

![Build Status](https://nepeters-devops.visualstudio.com/azure-blueprints/_apis/build/status/azure-blueprints-CI?branchName=master)

Test Deployment:

![Deployment Status Test](https://nepeters-devops.vsrm.visualstudio.com/_apis/public/Release/badge/6f0a6eee-bcec-4def-a3c3-eb6ac2005f71/2/2)

QA Deployment:

![Deployment Status QA](https://nepeters-devops.vsrm.visualstudio.com/_apis/public/Release/badge/6f0a6eee-bcec-4def-a3c3-eb6ac2005f71/2/5)

**Manual script execution**

```
pwsh CreateUpdateBlueprint.ps1 -TenantID $(az keyvault secret show --name AzureTenantID --vault-name nepeterskv007 --query value -o tsv) -ClientID $(az keyvault secret show --name AzureClientID --vault-name nepeterskv007 --query value -o tsv) -ClientSecret $(az keyvault secret show --name AzureClientSecret --vault-name nepeterskv007 --query value -o tsv) -SubscriptionId $(az keyvault secret show --name AzureSubscriptionID --vault-name nepeterskv007 --query value -o tsv) -Blueprint blueprint-body.json -ManagementGroup nepeters-internal -BlueprintName DevOpsBluePrint -Artifacts ./artifacts
```

```
pwsh AssignBlueprint.ps1 -TenantID $(az keyvault secret show --name AzureTenantID --vault-name nepeterskv007 --query value -o tsv) -ClientID $(az keyvault secret show --name AzureClientID --vault-name nepeterskv007 --query value -o tsv) -ClientSecret $(az keyvault secret show --name AzureClientSecret --vault-name nepeterskv007 --query value -o tsv) -SubscriptionId $(az keyvault secret show --name AzureSubscriptionID --vault-name nepeterskv007 --query value -o tsv) -Blueprint assign-blueprint-body.json -ManagementGroup nepeters-internal -BlueprintName DevOpsBluePrint
```
