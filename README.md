# App + DB Deployment

Deploys an app via Helm to AKS and a PostgreSQL Flexible Server into an existing peered VNet.
Handles Istio REGISTRY_ONLY via a ServiceEntry for DB egress.

## Before running

### Azure

- Storage account for Terraform state (update `terraform/backend.tf`)
- App Registration with client secret for CI (Needs to be added as Contributor to each environment RG)

### GitHub repo

- Create environments `dev`, `staging`, `prod` in Settings → Environments
- In each, add secrets:
  - `AZURE_CREDENTIALS` — output of `az ad sp create-for-rbac --sdk-auth`
  - `DB_PASSWORD` — the database password

### Code edits

File / What to change 

`deploy.yml` / `AKS_CLUSTER`, `AKS_RESOURCE_GROUP` 

`terraform/backend.tf` / `resource_group_name`, `storage_account_name`, `container_name` 

 `terraform/environments/*.tfvars` / `resource_group_name`, `vnet_name`, `db_subnet_name`, `dns_zone_id` 
