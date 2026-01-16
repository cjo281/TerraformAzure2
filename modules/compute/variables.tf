
# Compute
variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "frontend_subnet" {
  type = string
}

variable "backend_subnet" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "admin_ssh_public_key" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "frontend_vm_name" {
  type = string
}

variable "backend_vm_name" {
  type = string
}