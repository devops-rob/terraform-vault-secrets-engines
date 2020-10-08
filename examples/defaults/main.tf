provider "vault" {
  address = "http://localhost:8200"
  token = "root"
}

module "tc1_defaults" {
  source = "github.com/devops-rob/terraform-vault-secrets-engines"
}