variable "azure_subscription_id" {
  type        = string
  default     = null
  description = "Azure subscription ID"
}

variable "azure_tenant_id" {
  type        = string
  default     = null
  description = "Azure tenant ID"
}

variable "azure_client_id" {
  type        = string
  default     = null
  description = "Client ID for Azure Service Principal. WARNING - This will be written to the state file in plain text"
}

variable "azure_client_secret" {
  type        = string
  default     = null
  description = "Client secret for Azure Service Principal. WARNING - This will be written to the state file in plain text"
}

variable "azure_environment" {
  type        = string
  default     = "AzurePublicCloud"
  description = "The Azure cloud environment. Valid values: AzurePublicCloud, AzureUSGovernmentCloud, AzureChinaCloud, AzureGermanCloud.  Defaults to AzurePublicCloud"

  validation {
    condition     = can(contains(["AzurePublicCloud", "AzureUSGovernmentCloud", "AzureChinaCloud", "AzureGermanCloud"], var.azure_environment))
    error_message = "The Azure Environment value must be a valid identifier."
  }
}

variable "azure_secret_backend_role_name" {
  type        = string
  default     = null
  description = "Name for Azure secret backend role"
}

variable "azure_secret_backend_max_ttl" {
  type        = number
  default     = 3600
  description = "Maximum TTL for Azure secret backend."
}

variable "azure_secret_backend_ttl" {
  type        = number
  default     = 3600
  description = "Default TTL for Azure secret backend."
}

variable "use_resource_group" {
  type        = bool
  default     = true
  description = "Toggle to enable usage of Resource Groups for Azure Role Scopes"
}

variable "azure_role" {
  type        = string
  default     = "Reader"
  description = "Azure role to assigned to service principal. Must be one of Reader, Contributor, Owner"
}

variable "resource_group_identifier" {
  type        = string
  default     = null
  description = "Azure Resource Group Identifier"
}

locals {
  global_identifier = "/subscription/${var.azure_subscription_id}"
  local_identifier  = "/subscription/${var.azure_subscription_id}/resourceGroups/${var.resource_group_identifier}"
  azure_role_scope  = var.use_resource_group ? local.local_identifier : local.global_identifier
}

variable "azure_app_id" {
  type = string
  default = null
  description = "Application Object ID for an existing service principal that will be used instead of creating dynamic service principals. azure_roles will be ignored if this is used"
}