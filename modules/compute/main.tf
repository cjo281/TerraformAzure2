# Public IP for frontend VM
resource "azurerm_public_ip" "frontend_ip" {
  name                = "${var.frontend_vm_name}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"

}

# Network Interface - Frontend
resource "azurerm_network_interface" "frontend_nic" {
  name                = "${var.frontend_vm_name}-nic"
  location            = var.location
  resource_group_name = var.rg_name


  ip_configuration {
    name                          = "frontend-ipconfig"
    subnet_id                     = var.frontend_subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend_ip.id
  }
}

# Frontend VM
resource "azurerm_linux_virtual_machine" "frontend_vm" {
  name                = var.frontend_vm_name
  location            = var.location
  resource_group_name = var.rg_name
  size                = var.vm_size
  admin_username      = var.admin_username
  #admin_password      = var.admin_password

  disable_password_authentication = true

  admin_ssh_key {
  username   = var.admin_username
  public_key = var.admin_ssh_public_key
}
  
  network_interface_ids = [
    azurerm_network_interface.frontend_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts"
  version   = "latest"
}

}

# Network Interface - Backend
resource "azurerm_network_interface" "backend_nic" {
  name                = "${var.backend_vm_name}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "backend-ipconfig"
    subnet_id                     = var.backend_subnet
    private_ip_address_allocation = "Dynamic"
  }
}

# Backend VM
resource "azurerm_linux_virtual_machine" "backend_vm" {
  name                = var.backend_vm_name
  location            = var.location
  resource_group_name = var.rg_name
  size                = var.vm_size
  admin_username      = var.admin_username
  #admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.backend_nic.id
  ]

  disable_password_authentication = true

admin_ssh_key {
  username   = var.admin_username
  public_key = var.admin_ssh_public_key
}

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "0001-com-ubuntu-server-focal"
  sku       = "20_04-lts"
  version   = "latest"
}

}