resource "azurerm_lb" "lb" {
  name                = "loadbalancer"
  location            = "Eastus2"
  resource_group_name = var.resource_group_name
  sku                 = "Standard"


  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = var.public_ip_address_id
  }
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = "lb_rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_address_pool.id]
}

resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "backend-address"
}

resource "azurerm_lb_backend_address_pool_address" "lb_backend_address_pool_address" {
  name                    = "backend_pool_address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_address_pool.id
  virtual_network_id      = var.vnet_id
  ip_address              = var.ip_address_backend_lb
}
