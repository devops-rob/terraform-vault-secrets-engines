provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "db_defaults" {
  source          = "../../"
  secrets_engines = ["db"]
}