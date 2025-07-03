terraform {
    backend "azurerm" {
      resource_group_name = "rg-prod-infra" #RG qui contient le str account
      storage_account_name = "stracctfstate213"
      container_name = "tfstate" # container pour stocker les state files
      key = "prod.tfstate" #Blob qui sera crée dans le container
    }
    
}
