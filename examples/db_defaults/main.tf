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

  mysql_allowed_roles = ["*"]
  mysql_connection_url = "root:root@tcp(localhost:3306)/"


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
      rotation_statements = ["ALTER USER '{{name}}' WITH PASSWORD '{{password}}';"]
      rotation_period     = 86400

    }
  ]
}

