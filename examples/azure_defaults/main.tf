provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "azure_defaults" {
  source          = "../../"
  secrets_engines = ["azure"]

  azure_subscription_id = "11111111-2222-3333-4444-44444444444"
  azure_tenant_id       = "11111111-2222-3333-4444-44444444444"

  use_resource_group             = false
  azure_secret_backend_role_name = "test_role"
  azure_role                     = "tester"
}