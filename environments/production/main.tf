# Configure the Azure provider
provider "azurerm" {
  features {}
  subscription_id = "0fc82742-1d59-4d67-b7ff-9c56f3c0f0df"

}

# Resource Group
resource "azurerm_resource_group" "production" {
  name     = var.rg_name
  location = var.location
}

# Call networking module (if modularized)
module "networking" {
  source                = "../../modules/networking"
  rg_name               = azurerm_resource_group.production.name
  location              = var.location
  vnet_address_space    = var.vnet_address_space
  frontend_subnet_prefix = var.frontend_subnet_prefix
  backend_subnet_prefix  = var.backend_subnet_prefix
}


# Call compute module (frontend + backend VMs)
module "compute" {
  source          = "../../modules/compute"
  rg_name         = azurerm_resource_group.production.name
  location        = var.location
  frontend_subnet = module.networking.frontend_subnet_id
  backend_subnet  = module.networking.backend_subnet_id
  vm_size         = var.vm_size
  admin_username  = var.admin_username
  admin_password  = var.admin_password
  admin_ssh_public_key = var.admin_ssh_public_key
  frontend_vm_name = var.frontend_vm_name
  backend_vm_name  = var.backend_vm_name
}
# Call monitoring module (optional)
module "monitoring" {
  source   = "../../modules/monitoring"
  rg_name  = azurerm_resource_group.production.name
  location = var.location
  target_resource_id = azurerm_resource_group.production.id
  log_analytics_workspace_name = var.log_analytics_workspace_name
}
