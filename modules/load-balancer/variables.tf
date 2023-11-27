variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "public_ip_address_id" {
  description = "ID of the public IP address"
  type        = string
}

variable "vnet_id" {
  description = "ID of the virtual network"
  type        = string
}

variable "ip_address_backend_lb" {
  description = "IP address of backend for the load balancer"
  type        = string
}
