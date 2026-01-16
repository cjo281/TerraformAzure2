# Monitoring Module - variables.tf

variable "rg_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region for monitoring resources"
  type        = string
}

variable "target_resource_id" {
  description = "ID of the resource to attach diagnostics to"
  type        = string
}