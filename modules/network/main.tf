# vnet/main.tf

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

#subnet for acg
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefixes

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_network_profile" "network-profile" {
  name                = "network-profile"
  location            = "eastus2"
  resource_group_name = var.resource_group_name

  container_network_interface {
    name = "container-network-interface"

    ip_configuration {
      name      = "ip-config"
      subnet_id = azurerm_subnet.subnet.id
    }
  }
}

resource "azurerm_public_ip" "publicip" {
  name                = "publicip"
  location            = "Eastus2"
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "chupito"
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "public_ip_id" {
  value = azurerm_public_ip.publicip.id
}

output "network_profile_id" {
  value = azurerm_network_profile.network-profile.id
}
