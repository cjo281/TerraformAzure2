# Compute Module - outputs.tf

output "frontend_vm_id" {
  description = "ID of the frontend Windows VM"
  value       = azurerm_linux_virtual_machine.frontend_vm.id
}

output "backend_vm_id" {
  description = "ID of the backend Windows VM"
  value       = azurerm_linux_virtual_machine.backend_vm.id
}

output "frontend_public_ip" {
  description = "Public IP address of the frontend VM"
  value       = azurerm_public_ip.frontend_ip.ip_address
}

output "backend_private_ip" {
  description = "Private IP address of the backend VM"
  value       = azurerm_network_interface.backend_nic.private_ip_address
}