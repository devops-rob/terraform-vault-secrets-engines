provider "vault" {
  address = var.vault_addr
  token   = var.vault_token
}

variable "mysql_path" {
  default = "mysql"
}

variable "vault_addr" {
  default = "http://localhost:8200"
}

variable "vault_token" {}
variable "mysql_user" {}
variable "mysql_password" {}

module "mysql_static" {
  source          = "../../"
  secrets_engines = ["db"]

  databases = [
    "mysql"
  ]

  vault_token = var.vault_token
  vault_addr  = var.vault_addr

  mysql_path = var.mysql_path

  mysql_allowed_roles       = ["*"]
  mysql_connection_endpoint = "localhost:3306"

  mysql_username = var.mysql_user
  mysql_password = var.mysql_password

    db_roles = [
      {
        backend               = var.mysql_path
        name                  = "mysql-role"
        db_name               = "mysql"
        creation_statements   = ["CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';"]
        max_ttl               = 86400
        default_ttl           = 3600
        renew_statements      = []
        revocation_statements = []
        rollback_statements   = []
      }
    ]

  db_static_roles = [
    {
      backend             = var.mysql_path
      name                = "mysql-static-role"
      db_name             = "mysql"
      username            = "root"
      rotation_statements = ["ALTER USER '{{name}}' IDENTIFIED BY '{{password}}';"]
      rotation_period     = 86400


    }
  ]
}

