provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "ssh_defaults" {
  source          = "../../"
  secrets_engines = ["ssh"]

  ssh_backend_role_name = "test"
  ssh_key_type          = "otp"
  ssh_default_user      = "test-user"
}