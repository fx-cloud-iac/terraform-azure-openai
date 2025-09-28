data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_subnet" "pep" {
  count                = var.pep_vnet_name != "" ? 1 : 0
  name                 = var.pep_vnet_name != "" ? (contains(["dv1vnt001"], var.pep_vnet_name) ? "PrivateEndpoint2" : "PrivateEndpoint") : ""
  virtual_network_name = var.pep_vnet_name
  resource_group_name  = var.pep_vnet_resource_group_name != "" ? var.pep_vnet_resource_group_name : data.azurerm_resource_group.rg.name
}

resource "random_string" "random" {
  length      = 4
  special     = false
  upper       = false
  min_numeric = 1
}

# OpenAI resource
resource "azurerm_cognitive_account" "openai" {
  name                          = var.name == "" ? "oai-${local.suffix}" : var.name
  location                      = local.location
  resource_group_name           = data.azurerm_resource_group.rg.name
  kind                          = "OpenAI"
  sku_name                      = "S0"
  local_auth_enabled            = var.local_auth_enabled
  custom_subdomain_name         = var.name == "" ? "ai-${local.suffix}" : var.name
  public_network_access_enabled  = var.public_access_enabled

  network_acls {
    default_action = var.public_access_enabled ? "Allow" : "Deny"
    ip_rules       = []
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}

# Private endpoint
resource "azurerm_private_endpoint" "pep" {
  count               = var.pep_vnet_name != "" ? 1 : 0
  name                = "${azurerm_cognitive_account.openai.name}-pep"
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = data.azurerm_subnet.pep[0].id

  private_service_connection {
    name                           = "${azurerm_cognitive_account.openai.name}-psc"
    private_connection_resource_id = azurerm_cognitive_account.openai.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "default_dns_zone"
    private_dns_zone_ids = [local.private_dns_zone]
  }

  tags = local.tags
}
