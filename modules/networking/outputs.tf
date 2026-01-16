# Networking Module - outputs.tf

output "frontend_subnet_id" {
  description = "ID of the frontend subnet"
  value       = azurerm_subnet.frontend.id
}

output "backend_subnet_id" {
  description = "ID of the backend subnet"
  value       = azurerm_subnet.backend.id
}

output "frontend_nsg_id" {
  description = "ID of the frontend NSG"
  value       = azurerm_network_security_group.frontend_nsg.id
}

output "backend_nsg_id" {
  description = "ID of the backend NSG"
  value       = azurerm_network_security_group.backend_nsg.id
}