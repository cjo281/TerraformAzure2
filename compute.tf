# Public IP for frontend VM
resource "azurerm_public_ip" "frontend_ip" {
  name                = "${var.frontend_vm_name}-pip"
  location            = azurerm_resource_group.staging.location
  resource_group_name = azurerm_resource_group.staging.name
  allocation_method   = "Dynamic"
}

# Network Interface - Frontend
resource "azurerm_network_interface" "frontend_nic" {
  name                = "${var.frontend_vm_name}-nic"
  location            = azurerm_resource_group.staging.location
  resource_group_name = azurerm_resource_group.staging.name

  ip_configuration {
    name                          = "frontend-ipconfig"
    subnet_id                     = azurerm_subnet.frontend.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend_ip.id
  }
}

# Frontend VM
resource "azurerm_windows_virtual_machine" "frontend_vm" {
  name                = var.frontend_vm_name
  location            = azurerm_resource_group.staging.location
  resource_group_name = azurerm_resource_group.staging.name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.frontend_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Network Interface - Backend
resource "azurerm_network_interface" "backend_nic" {
  name                = "${var.backend_vm_name}-nic"
  location            = azurerm_resource_group.staging.location
  resource_group_name = azurerm_resource_group.staging.name

  ip_configuration {
    name                          = "backend-ipconfig"
    subnet_id                     = azurerm_subnet.backend.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Backend VM
resource "azurerm_windows_virtual_machine" "backend_vm" {
  name                = var.backend_vm_name
  location            = azurerm_resource_group.staging.location
  resource_group_name = azurerm_resource_group.staging.name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.backend_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}