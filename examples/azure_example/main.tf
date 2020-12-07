provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

variable "vault_token" {}
variable "azure_subscription_id" {}
variable "azure_tenant_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}

module "azure_defaults" {
  source          = "../../"
  secrets_engines = ["azure"]

  azure_subscription_id = var.azure_subscription_id
  azure_tenant_id       = var.azure_tenant_id
  azure_client_id       = var.azure_client_id
  azure_client_secret   = var.azure_client_secret

  use_resource_group             = false
  azure_secret_backend_role_name = "test_role"
  azure_role                     = "owner"
}