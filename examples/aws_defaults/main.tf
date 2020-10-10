provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "aws_defaults" {
  source = "../../"

  secrets_engines       = ["aws"]
  aws_backend_role_name = "test"
  aws_iam_groups        = ["test"]
}
