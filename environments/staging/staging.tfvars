location = "eastus"
rg_name  = "RG-Staging"
vnet_address_space = ["10.0.0.0/16"]
frontend_subnet_prefix = ["10.0.1.0/24"]
backend_subnet_prefix = ["10.0.2.0/24"]
vm_size  = "Standard_B1s"
admin_username = "azureuser"
admin_password = "P@ssword1234!"
admin_ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAlrK+FK4Tt82jTsf7ho6LGACG2Obv95jpp4/RdtNItn terraform-vm-key"
frontend_vm_name = "frontend-vm-staging"
backend_vm_name = "backend-vm-staging"

