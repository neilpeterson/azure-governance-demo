# Azure Blueprints demos

[![Build Status](https://nepeters-devops.visualstudio.com/azure-blueprints/_apis/build/status/azure-blueprints-CI?branchName=master)](https://nepeters-devops.visualstudio.com/azure-blueprints/_build/latest?definitionId=8?branchName=master)

## Azure RBAC

**Portal Intro to RBAC**

- Show subscription and established roles (1 owner, 1 reader)
- Log in as reader and attempt to create something
- Update reader to Restart VM (custom role) and show result

**Automation**

Create custom role with Azure CLI

```
cd ~/storage/speaking-engagements/talk-azure-governance/rbac
az role definition create --role-definition container-instances-all.json
```

Assign custom role with Azure CLI

```
cd ~/storage/speaking-engagements/talk-azure-governance/rbac
az role assignment create --role "Container Instances Read / Write" --assignee rebecca@nepeters.com
```

## Azure Policy

**Audit / Resource Group Location**

Manually create policy to demo portal and build in policy.

**Deny / Naming:**

Enforce a **naming convention** for a **named resource type**, **deny** if not met.

```
cd ~/storage/speaking-engagements/talk-azure-governance/policy/name-by-type
sh ./policyEnforceName.sh
```

**Deny:**

Enforce a tag, **deny** if not specified.

```
cd ~/storage/speaking-engagements/talk-azure-governance/policy/tag-deny
sh ./policyTagDeny.sh
```

**Append:**

Enforce a tag, **apply** if not specified.

```
cd ~/storage/speaking-engagements/talk-azure-governance/policy/tag-append
sh ./policyTagAppend.sh
```

**Audit:**

TODO - add policy that perhaps audits all resource group locations?

**Initiative:**

TODO - add CLI example for initiative.

## Azure Blueprints

**Manual Demo**

Create blueprint consisting of two of the above policies, and resource group, and Resource Manager template.

**Rest Demo**

REST interface is the only automation tooling available. It's rough, but demo for demo sake.

Create and Publish:

```
cd ~/storage/speaking-engagements/talk-azure-governance/blueprints/create-blueprint
pwsh ./CreateUpdateBlueprint.ps1
```

Assign:

```
cd ~/storage/speaking-engagements/talk-azure-governance/blueprints/assign-blueprint
pwsh ./AssignBlueprint.ps1
```

**Azure DevOPs and Blueprints**

[![Build Status](https://nepeters-devops.visualstudio.com/azure-blueprints/_apis/build/status/azure-blueprints-CI?branchName=master)](https://nepeters-devops.visualstudio.com/azure-blueprints/_build/latest?definitionId=8?branchName=master)
