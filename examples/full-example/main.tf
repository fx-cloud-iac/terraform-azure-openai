terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }
}

provider "azurerm" {
  subscription_id = "43b6e394-4ebb-4ee2-8868-ab52fa37c8e5"
  features {}
}

module "azure_openai" {
  source = "../../"

  name                        = var.name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  pep_vnet_name               = var.pep_vnet_name
  pep_vnet_resource_group_name = var.pep_vnet_resource_group_name
  private_endpoint_vnet_exceptions = var.private_endpoint_vnet_exceptions
  local_auth_enabled          = false
  public_access_enabled       = false
}
