provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}

variable "postgresql_path" {
  default = "postgresql"
}

variable "vault_addr" {
  default = "http://localhost:8200"
}

variable "vault_token" {}
variable "postgresql_username" {}
variable "postgresql_password" {}

module "postgresql_static" {
  source          = "../../"
  secrets_engines = ["db"]

  databases = [
    "postgresql"
  ]

  vault_token = var.vault_token
  vault_addr  = var.vault_addr

  postgresql_path = var.postgresql_path

  postgresql_allowed_roles  = ["*"]
  postgresql_connection_endpoint = "localhost:5432"

  postgresql_username = var.postgresql_username
  postgresql_password = var.postgresql_password

  db_roles = [
    {
      backend               = var.postgresql_path
      name                  = "readonly"
      db_name               = "postgresql"
      creation_statements   = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}' INHERIT; GRANT ro TO \"{{name}}\";"]
      max_ttl               = 86400
      default_ttl           = 3600
      renew_statements      = []
      revocation_statements = ["ALTER ROLE \"{{name}}\" NOLOGIN;"]
      rollback_statements   = []
    }
  ]

  db_static_roles = [
    {
      backend             = var.postgresql_path
      name                = "postgresql-static-role"
      db_name             = "postgresql"
      username            = var.postgresql_username
      rotation_statements = ["ALTER USER \"{{name}}\" WITH PASSWORD '{{password}}';"]
      rotation_period     = 86400


    }
  ]
}

