# azure container registry

variable "acr_name" {
  description = "Name of the container registry"
  type        = string
}

variable "location" {
  description = "Azure region where the azure container registry will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "admin_enabled" {
  description = "Admin enabled"
  type        = bool
}

variable "sku" {
  description = "Level o sku"
  type        = string
}
