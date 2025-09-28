output "name" {
  description = "The name of the OpenAI resource"
  value       = azurerm_cognitive_account.openai.name
}

output "resource_group_name" {
  description = "The name of the OpenAI's resource group"
  value       = data.azurerm_resource_group.rg.name
}
