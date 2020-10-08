provider "vault" {
  address = "http://localhost:8200"
  token = "root"
}

module "example_defaults" {
  source = "../../"
}