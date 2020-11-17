provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

variable "vault_token" {}
variable "consul_token" {}

module "consul_defaults" {
  source          = "../../"
  secrets_engines = ["consul"]

  consul_address           = "http://localhost:8500"
  consul_token             = var.consul_token
  consul_backend_role_name = "test"

  consul_policies = [
    "test-policy",
    "test-policy-2"
  ]
}