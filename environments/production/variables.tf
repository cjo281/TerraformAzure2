# General settings
variable "location" {
  description = "Azure region for resources"
  #default     = "eastus"
}

variable "rg_name" {
  description = "Resource group name for staging"
  #default     = "RG-Production"
}

# Networking
variable "vnet_address_space" {
  description = "Address space for the VNet"
  #default     = ["10.1.0.0/16"]
}

variable "frontend_subnet_prefix" {
  description = "Frontend subnet CIDR"
  #default     = ["10.1.1.0/24"]
}

variable "backend_subnet_prefix" {
  description = "Backend subnet CIDR"
  #default     = ["10.1.2.0/24"]
}

# Compute
variable "vm_size" {
  description = "Size of the VMs"
  #default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Admin username for VMs"
  #default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for VMs"
  #default     = "P@ssword1234!" # Replace with secure value or use Key Vault
  sensitive = true
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key for VM login"
}

variable "frontend_vm_name" {
  description = "Frontend VM name"
  #default     = "frontend-vm-production"
}

variable "backend_vm_name" {
  description = "Backend VM name"
  #default     = "backend-vm-production"
}
variable "log_analytics_workspace_name" {
  type = string
}