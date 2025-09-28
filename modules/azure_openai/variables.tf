variable "name" {
  description = "Name of the OpenAI resource. Leave empty if you want auto-generation."
  type        = string
  default     = ""

  validation {
    condition     = var.name == "" || can(regex("^oai-[0-9]{4,5}-[a-z]{2,5}-..-[a-z0-9]{4}$", var.name))
    error_message = "The name must follow the pattern 'oai-####-?????-??-####' where 'oai-APPID-ENV-SHORTREGION-RANDOMSUFFIX'."
  }
}

variable "local_auth_enabled" {
  description = "Whether to enabled local authentication (api key) or not. When local_auth_enabled is 'false', resource uses RBAC for authentication & authorization, otherwise, it uses a key."
  type        = bool
  default     = false
}

variable "public_access_enabled" {
  description = "Whether the OpenAI endpoint can be accessed from Internet or not. When public_access_enabled is true the endpoint is public, and can be accessed from Internet. Otherwise, the endpoint can only be accessed from within the internal network via private endpoint."
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "The resource group where to deploy the resource."
  type        = string
}

variable "pep_vnet_resource_group_name" {
  description = "The name of the virtual network's resource group where to deploy a private endpoint. Leave empty, unless you want to override the resource group."
  type        = string
  default     = ""
}

variable "pep_vnet_name" {
  description = "The name of the virtual network where to deploy a private endpoint. Leave empty, unless you want to override the virtual network."
  type        = string
  default     = ""
}

variable "location" {
  description = "The Azure region where to deploy the resource."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Your resource tags, if have any."
  type        = map(string)
  default     = {}
}

variable "private_endpoint_vnet_exceptions" {
  description = "List of VNETs that use PrivateEndpoint2 for private endpoint subnet"
  type        = list(string)
  default     = ["dv1vnt001"]
}
