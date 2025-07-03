# Azure Resource Management with Terraform / Azure DevOps
## Project Structure 📁
```bash
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   └── variables.tf
    │   └── backend.tf
│   └── prod/
│       ├── main.tf
│       └── variables.tf
|       └── backend.tf
├── modules/
│   ├── ResourceGroup/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── VirtualNetwork/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── pipelines/
│   ├── create-infrastructure.yml
│   └── destroy-infrastructure.yml

├── providers.tf
└── README.md
```

## Objective
This Terraform project automates the creation and deletion of Azure infrastructure for different environments (dev and prod), using reusable modules and Azure DevOps CI/CD pipelines.

## Technologies Used
- Terraform v1.3.9
- Azure DevOps Pipelines
- AzureRM Provider ~> 3.0

## Remote State Configuration
Terraform State is stored in the cloud in the **stracctfstate213** resource group to enable *collaboration* and *consistency*

```hcl
terraform {
    backend "azurerm" {
      resource_group_name = "rg-dev-infra" # RG containing the storage account
      storage_account_name = "stracctfstate213"
      container_name = "tfstate" # container to store state files
      key = "terraform.tfstate" # Blob created in the container
    }
}
```

## Prerequisites
- Terraform installed
- Azure CLI authentication
- Azure Service Principal with necessary permissions
- Access to Azure storage account for state management

---

## Modules

### modules/ResourceGroup
This module manages Azure resource group creation with defined tags:
- `env` : Environment (dev, prod, etc.)
- `project` : Project name
- `location` : Azure region (default: `France Central`)

####  Outputs
- resource_group_name : Resource group name
- resource_group_id : Resource group ID

### modules/VirtualNetwork
This module manages Azure virtual network infrastructure:
- Virtual Network with customizable address space
- Multiple subnets with configurable CIDR blocks
- Network Security Groups with predefined rules
- Route tables for traffic management

####  Outputs
- vnet_id : Virtual network ID
- subnet_ids : Map of subnet IDs
- nsg_ids : Map of Network Security Group IDs

---

##  Environments
Each environment (dev and prod) has its own files:
- main.tf : Module reference and environment-specific variables
- variables.tf : Variable declarations

##  CI/CD Pipelines

#### pipelines/create-infrastructure.yml
Deployment pipeline:
- **Deploy_Dev** stage: deploys to development environment
- **Deploy_Prod** stage: deploys to **prod** only if **dev** succeeds

#### pipelines/destroy-infrastructure.yml
**Destruction** pipeline (manual execution):
- Destroy_Dev and Destroy_Prod stages to remove respective resources

##### Required Environment Variables (via Variable Group `TerraformSecrets`)
- servicePrincipalId
- servicePrincipalKey
- subscriptionId
- tenantId

## Useful Terraform Commands

#### Initialize an environment:
```bash
cd environments/dev     # or prod
terraform init
```

#### Validate and plan:
```bash
terraform validate
terraform plan
```

#### Apply changes:
```bash
terraform apply
```

#### Destroy resources:
```bash
terraform destroy
```

## Best Practices
- Never manually modify the `terraform.tfstate` file
- Use pipelines for production deployments
- Centralize secrets in Azure DevOps (`TerraformSecrets`)
- Keep modules generic and reusable
- Use consistent naming conventions
- Implement proper tagging strategy

## Contact
For questions or improvements, please contact do a pull request.
