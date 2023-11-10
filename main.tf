# resource group
resource "azurerm_resource_group" "az-capabilities-rg" {
  name     = "az-capabilities-rg"
  location = "eastus2"
}

# vnet
resource "azurerm_virtual_network" "az-capabilities-vnet-1" {
  name = "az-capabilities-vnet-1"
  location = "eastus2"
  resource_group_name = "az-capabilities-rg"
  address_space = ["10.0.0.0/16"]
}

#azure container registry
resource "azurerm_container_registry" "az-capabilities-acr" {
  name                     = "azcapabilitiesacr"
  resource_group_name      = "az-capabilities-rg"
  location                 = "eastus2"
  admin_enabled            = true
  sku                      = "Standard"
  
}

# #Push front-end image and push to the containerregistrychupito
# resource "null_resource" "push_image" {
#    triggers = {
#      registry_login_server = azurerm_container_registry.container-registry.login_server
#    }

#    provisioner "local-exec" {
#      command = "az acr login --name containerregistrychupito"
#    }

#   provisioner "local-exec" {
#      command = "docker tag fe-chupito:v5 containerregistrychupito.azurecr.io/fe-chupito:v5"
#    }

#    provisioner "local-exec" {
#      command = "docker push containerregistrychupito.azurecr.io/fe-chupito:v5"
#    }
#   }

#Push any image and push to the containerregistrychupito
resource "null_resource" "push_image" {
   triggers = {
     registry_login_server = azurerm_container_registry.az-capabilities-acr.login_server
   }

   provisioner "local-exec" {
     command = "az acr login --name azcapabilitiesacr"
   }

  provisioner "local-exec" {
     command = "docker tag kodekloud/simple-webapp:latest azcapabilitiesacr.azurecr.io/simple-app:prueba"
   }

   provisioner "local-exec" {
     command = "docker push azcapabilitiesacr.azurecr.io/simple-app:prueba"
   }
  }

#azure container instance - fronted
resource "azurerm_container_group" "az-capabilties-aci" {
 name                = "az-capabilties-acg"
 location            = "eastus2"
 resource_group_name = "az-capabilities-rg"
 ip_address_type     = "Public"
 os_type = "Linux"
    
    image_registry_credential {
      server = "azcapabilitiesacr.azurecr.io"
      username = "azcapabilitiesacr"
      password = "LekZfSMp0HoO9XqLC0KFta2DejNDDe4xNQyuW2fm4X+ACRBTooXV"
    }

  container {
    name   = "az-capabilties-container"
    image  = "azcapabilitiesacr.azurecr.io/simple-app:prueba"
    cpu    = 1
    memory = 1
  
    ports {
      port     = 8080
      protocol = "TCP"
    }
  }
}