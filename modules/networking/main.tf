

# Networking Module - main.tf

resource "azurerm_virtual_network" "main_vnet" {
  name                = "lab-vnet"
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "frontend" {
  name                 = "frontend-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = var.frontend_subnet_prefix
}

resource "azurerm_subnet" "backend" {
  name                 = "backend-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = var.backend_subnet_prefix
}

resource "azurerm_network_security_group" "frontend_nsg" {
  name                = "frontend-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "backend_nsg" {
  name                = "backend-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "AllowFrontend"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433" # Example DB port
    source_address_prefix      = azurerm_subnet.frontend.address_prefixes[0]
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "frontend_assoc" {
  subnet_id                 = azurerm_subnet.frontend.id
  network_security_group_id = azurerm_network_security_group.frontend_nsg.id
}

resource "azurerm_subnet_network_security_group_association" "backend_assoc" {
  subnet_id                 = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.backend_nsg.id
}