# Azure Governance Demos

## Azure RBAC

**Portal Intro to RBAC**

- Show subscription and established roles (1 owner, 1 reader)
- Log in as reader and attempt to create something
- Update reader to ? and show changes

**Automation**

- Change user back to reader using the Azure CLI

**Automtaion Templates**

- Deploy a new service and configure IAM .via template

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

Create blue print consisting of two of the above policies, and resource group, and Resource Manager template.

**Rest Demo**

REST interface is the only automation tooling available. It's rough, but demo for demo sake.

Create and Publish:

```
cd ~/storage/speaking-engagements/talk-azure-governance/blueprints/create-blueprint
pwsh ./CreateUpdateBlueprint.ps1
```

Assign (NOT Working):

```
cd ~/storage/speaking-engagements/talk-azure-governance/blueprints/assign-blueprint
pwsh ./AssignBlueprint.ps1
```

**STRETCH: Azure DevOPs and Blueprints**

TODO - working on this.