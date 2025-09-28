output "name" {
  description = "The name of the OpenAI resource"
  value       = module.azure_openai.name
}

output "resource_group_name" {
  description = "The name of the OpenAI's resource group"
  value       = module.azure_openai.resource_group_name
}
