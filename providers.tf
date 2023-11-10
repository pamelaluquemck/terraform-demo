terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.1"
    }
  }
}

provider "azurerm" {
  features {}
}