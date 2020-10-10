provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "pki_defaults" {
  source          = "../../"
  secrets_engines = ["pki"]
}