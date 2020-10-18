provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

variable "mysql_path" {
  default = "mysql"
}

module "db_defaults" {
  source          = "../../"
  secrets_engines = ["db"]

  databases = [
    "mysql"
  ]

  mysql_path = var.mysql_path

  db_roles = [
    {
      backend               = var.mysql_path
      name                  = "mysql-role"
      db_name               = "mysql"
      creation_statements   = ["CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
      max_ttl               = 3600
      default_ttl           = 3600
      renew_statements      = []
      revocation_statements = []
      rollback_statements   = []
    }
  ]
}

