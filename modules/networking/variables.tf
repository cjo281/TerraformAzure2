
# Networking Module - variables.tf

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "frontend_subnet_prefix" {
  description = "CIDR prefix for the frontend subnet"
  type        = list(string)
}

variable "backend_subnet_prefix" {
  description = "CIDR prefix for the backend subnet"
  type        = list(string)
}