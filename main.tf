# resource group
resource "azurerm_resource_group" "az-capabilities-rg" {
  name     = var.rg_name
  location = var.location
}

# virtual network
module "network" {
  source              = "./modules/network"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.az-capabilities-rg.location
  resource_group_name = azurerm_resource_group.az-capabilities-rg.name
  subnet_name         = "az-capabilities-subnet-1"
  address_prefixes    = ["10.0.0.0/24"]
}

# azure container registry
module "acr" {
  source              = "./modules/container-registry"
  acr_name            = var.acr_name
  location            = azurerm_resource_group.az-capabilities-rg.location
  resource_group_name = azurerm_resource_group.az-capabilities-rg.name
  admin_enabled       = var.admin_enabled
  sku                 = var.sku
}

module "acg" {
  source              = "./modules/container-instance"
  acg_name            = var.acg_name
  location            = azurerm_resource_group.az-capabilities-rg.location
  resource_group_name = azurerm_resource_group.az-capabilities-rg.name
  ip_address_type     = var.ip_address_type
  os_type             = var.os_type
  acr_login_server    = module.acr.acr_login_server
  acr_admin_username  = module.acr.acr_admin_username
  acr_admin_password  = module.acr.acr_admin_password
  aci_name            = var.aci_name
  image               = "${module.acr.acr_login_server}/fe-chupito:prueba"
  cpu                 = var.cpu
  memory              = var.memory
  port                = var.port
  protocol            = var.protocol
  network_profile_id  = module.network.network_profile_id
}

# load balancer
module "load_balancer" {
  source                = "./modules/load-balancer"
  resource_group_name   = azurerm_resource_group.az-capabilities-rg.name
  vnet_id               = module.network.vnet_id
  ip_address_backend_lb = module.acg.ip_address
  public_ip_address_id  = module.network.public_ip_id
}

output "ip_adress" {
  value = module.acg.ip_address
}
