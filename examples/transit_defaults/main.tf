provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "transit_defaults" {
  source          = "../../"
  secrets_engines = ["transit"]
}