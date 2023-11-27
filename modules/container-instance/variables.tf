# azure container instance

variable "acg_name" {
  description = "Name of the container group"
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

variable "ip_address_type" {
  description = "Type of ip address: private or public"
  type        = string
}

variable "os_type" {
  description = "Type of os_type"
  type        = string
}

variable "acr_login_server" {
  description = "Value of the login server"
  type        = string
}

variable "acr_admin_username" {
  description = "Value of the admin username"
  type        = string
}

variable "acr_admin_password" {
  description = "Value of the admin password"
  type        = string
}

variable "aci_name" {
  description = "Name of the container instance"
  type        = string
}

variable "image" {
  description = "Source of image"
  type        = string
}

variable "cpu" {
  description = "value of cpu"
  type        = number
}

variable "memory" {
  description = "value of memory"
  type        = number
}

variable "port" {
  description = "value of port"
  type        = number
}

variable "protocol" {
  description = "value of protocol"
  type        = string
}

variable "network_profile_id" {
  description = "value of network profile id"
  type        = string
}
