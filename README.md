# Azure Governance Demos

## Azure RBAC

TODO - Populate Demos

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