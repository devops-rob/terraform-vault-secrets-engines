provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "consul_defaults" {
  source          = "../../"
  secrets_engines = ["consul"]

  consul_token             = "acl-token"
  consul_backend_role_name = "test"

  consul_policies = [
    "test-policy",
    "test-policy-2"
  ]
}