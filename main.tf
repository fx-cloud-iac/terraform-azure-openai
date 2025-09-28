module "azure_openai" {
  source = "./modules/azure_openai/"

  name                        = var.name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  # Custom private endpoint configuration
  pep_vnet_resource_group_name = var.pep_vnet_resource_group_name
  pep_vnet_name               = var.pep_vnet_name
  local_auth_enabled          = var.local_auth_enabled
  public_access_enabled       = var.public_access_enabled
}
