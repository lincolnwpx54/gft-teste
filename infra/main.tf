provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "./modules/resource_group"
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "vpn" {
  source              = "./modules/vpn"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vnet_id             = module.vnet.id
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  subnet_id           = module.vnet.subnet_app_id
}

# Outros módulos: redis, postgres, apim, gateway, monitoring...
