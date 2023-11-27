# vnet/variables.tf

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space of the virtual network"
  type        = list(string)
}

variable "location" {
  description = "Azure region where the virtual network will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

#subnet for acg
variable "subnet_name" {
  description = "name of subnet_id"
  type        = string
}

variable "address_prefixes" {
  description = "value of address_prefixes"
  type        = list(string)
}
