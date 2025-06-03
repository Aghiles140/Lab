provider "azurerm" {
    features {}
}

module "ResourceGroup" {
    source   = "../../modules/ResourceGroup"
    env      = "Prod" #nom Env
    project  = "TestProject" #nom Projet
    location = "France Central" #Region
}

module "VirtualNetwork" {
  source              = "../../modules/VirtualNetwork"
  env                 = "prod"
  project             = "TestProject"
  location            = "France Central"
  address_space       = ["172.16.0.0/16"]
  resource_group_name = module.ResourceGroup.Resource_group_name
  subnets = {
    "sn-web" = {
      address_prefix = "172.16.1.0/24"
        },
    "sn-app" = {
      address_prefix = "172.16.2.0/24"
        },
    "sn-db" = {
      address_prefix = "172.16.3.0/24"
        }
    }
}
