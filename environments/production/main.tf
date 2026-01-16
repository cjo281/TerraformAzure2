# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "staging" {
  name     = var.rg_name
  location = var.location
}

# Call networking module (if modularized)
module "networking" {
  source                = "../../modules/networking"
  rg_name               = azurerm_resource_group.lab_rg.name
  location              = var.location
  vnet_address_space    = var.vnet_address_space
  frontend_subnet_prefix = var.frontend_subnet_prefix
  backend_subnet_prefix  = var.backend_subnet_prefix
}


# Call compute module (frontend + backend VMs)
module "compute" {
  source          = "../../modules/compute"
  rg_name         = azurerm_resource_group.lab_rg.name
  location        = var.location
  frontend_subnet = module.networking.frontend_subnet_id
  backend_subnet  = module.networking.backend_subnet_id
  vm_size         = var.vm_size
  admin_username  = var.admin_username
  admin_password  = var.admin_password
  frontend_vm_name = var.frontend_vm_name
  backend_vm_name  = var.backend_vm_name
}
# Call monitoring module (optional)
module "monitoring" {
  source   = "../../modules/monitoring"
  rg_name  = azurerm_resource_group.lab_rg.name
  location = var.location
}
