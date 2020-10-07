resource "vault_mount" "secrets_engines" {
  count = length(var.secrets_engines)
  path  = element(var.secrets_engines, count.index)
  type  = element(var.secrets_engines, count.index)

  default_lease_ttl_seconds = var.default_lease
  max_lease_ttl_seconds     = var.max_lease

  seal_wrap               = var.seal_wrap
  local                   = var.local_mount
  external_entropy_access = var.external_entropy_access

  description = "The ${element(var.secrets_engines, count.index)} secrets engine is mounted at the /${element(var.secrets_engines, count.index)} path"

}

resource "vault_aws_secret_backend" "aws_backend" {
  count = contains(var.secrets_engines, "aws") ? 1 : 0
  path  = "aws"

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region

  default_lease_ttl_seconds = var.aws_default_lease
  max_lease_ttl_seconds     = var.aws_max_lease

}