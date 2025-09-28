variable "resource_group_name" {
  description = "Resource group"
  type        = string
}

variable "pep_vnet_name" {
  description = "The name of the virtual network where to deploy a private endpoint. Leave empty, unless you want to override the virtual network."
  type        = string
  default     = ""
}

variable "pep_vnet_resource_group_name" {
  description = "The name of the virtual network's resource group where to deploy a private endpoint. Leave empty, unless you want to override the resource"
  type        = string
  default     = ""
}
