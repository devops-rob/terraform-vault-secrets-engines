provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

variable "vault_token" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_groups" {
  type = list(string)
  default = [
    "test1",
    "test2"
  ]
}

module "aws_defaults" {
  source = "../../"

  secrets_engines       = ["aws"]
  aws_backend_role_name = "test"
  aws_iam_groups        = var.aws_groups

  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
}
