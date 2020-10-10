provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "ssh_defaults" {
  source          = "../../"
  secrets_engines = ["ssh"]
}