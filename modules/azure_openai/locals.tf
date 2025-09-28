locals {
  location = var.location == "" ? data.azurerm_resource_group.rg.location : var.location

  common_tags = data.azurerm_resource_group.rg.tags

  tags = merge(var.tags, local.common_tags) # on ne laisse pas overrider les tags par defaut

  subscriptions = {
    non_prod = {
      "67caf15a-9a11-4122-8a3f-17eb83d2175b" = "pppp"
      "43b6e394-4ebb-4ee2-8868-ab52fa37c8e5" = "pr"
      "8c8c8c8c-8c8c-8c8c-8c8c-8c8c8c8c8c8c" = "hc"
      "9d9d9d9d-9d9d-9d9d-9d9d-9d9d9d9d9d9d" = "gn"
      "aeaeaeae-aeae-aeae-aeae-aeaeaeaeaeae" = "idt"
      "bfbfbfbf-bfbf-bfbf-bfbf-bfbfbfbfbfbf" = "cxpre"
      "c0c0c0c0-c0c0-c0c0-c0c0-c0c0c0c0c0c0" = "cxprc"
      "d1d1d1d1-d1d1-d1d1-d1d1-d1d1d1d1d1d1" = "tools"
      "e2e2e2e2-e2e2-e2e2-e2e2-e2e2e2e2e2e2" = "sasepr"
      "f3f3f3f3-f3f3-f3f3-f3f3-f3f3f3f3f3f3" = "crypto"
      "g4g4g4g4-g4g4-g4g4-g4g4-g4g4g4g4g4g4" = "prpp"
    }
    prod = {
      "h5h5h5h5-h5h5-h5h5-h5h5-h5h5h5h5h5h5" = "pr"
      "i6i6i6i6-i6i6-i6i6-i6i6-i6i6i6i6i6i6" = "hc"
      "j7j7j7j7-j7j7-j7j7-j7j7-j7j7j7j7j7j7" = "gn"
      "k8k8k8k8-k8k8-k8k8-k8k8-k8k8k8k8k8k8" = "idt"
      "l9l9l9l9-l9l9-l9l9-l9l9-l9l9l9l9l9l9" = "cxpre"
      "m0m0m0m0-m0m0-m0m0-m0m0-m0m0m0m0m0m0" = "cxprc"
      "n1n1n1n1-n1n1-n1n1-n1n1-n1n1n1n1n1n1" = "tools"
      "o2o2o2o2-o2o2-o2o2-o2o2-o2o2o2o2o2o2" = "sasepr"
      "p3p3p3p3-p3p3-p3p3-p3p3-p3p3p3p3p3p3" = "crypto"
      "q4q4q4q4-q4q4-q4q4-q4q4-q4q4q4q4q4q4" = "prpp"
    }
  }

  location_codes = {
    canadacentral = "cc"
    canadaeast    = "ce"
  }

  region_codes = {
    cc = "1"
    ce = "2"
  }

  application_code = data.azurerm_resource_group.rg.tags.application_id
  subscription_codes = merge(values(local.subscriptions)...)
  short_subscription = local.subscription_codes[data.azurerm_client_config.current.subscription_id]
  short_location = local.location_codes[local.location]
  base_name = "${local.application_code}-${local.short_subscription}-${local.short_location}"
  suffix = "${local.base_name}-${random_string.random.result}"
  private_dns_zone_resource_id = "/subscriptions/db52fd96-65f7-4094-8cd7-ff3dbd3f9bdd/resourceGroups/gn1rgpvnet001/providers/Microsoft.Network/privateDnsZones/privatelink.openai.azure.com"
  private_dns_zone = "${local.private_dns_zone_resource_id}/privatelink.openai.azure.com"
}
