variable "resource_group_name" {
  description = "Resource group"
  type        = string
}

variable "location" {
  description = "Region location"
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

variable "private_endpoint_vnet_exceptions" {
  description = "List of VNETs that use PrivateEndpoint2 for private endpoint subnet"
  type        = list(string)
  default     = ["dv1vnt001"]
}

variable "name" {
  description = "Name of the OpenAI resource. Leave empty if you want auto-generation."
  type        = string
  default     = ""

  validation {
    condition     = var.name == "" || can(regex("^oai-[0-9]{4,5}-[a-z]{2,5}-..-[a-z0-9]{4}$", var.name))
    error_message = "The name must follow the pattern 'oai-####-?????-??-####' where 'oai-APPID-ENV-SHORTREGION-RANDOMSUFFIX'."
  }
}
