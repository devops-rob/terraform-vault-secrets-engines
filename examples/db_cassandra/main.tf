provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

variable "cassandra_path" {
  default = "cassandra"
}

variable "vault_token" {}
variable "cassandra_username" {}
variable "cassandra_password" {}

module "cassandra_static" {
  source          = "../../"
  secrets_engines = ["db"]

  databases = [
    "cassandra"
  ]

  vault_token = var.vault_token
  vault_addr  = "http://localhost:8200"

  cassandra_path = var.cassandra_path

  cassandra_allowed_roles = ["*"]
  cassandra_hosts         = ["127.0.0.1"]

  cassandra_username = var.cassandra_username
  cassandra_password = var.cassandra_password
  cassandra_tls      = false

  cassandra_protocol_version = 4

  db_roles = [
    {
      backend               = var.cassandra_path
      name                  = "readonly"
      db_name               = var.cassandra_path
      creation_statements   = ["CREATE USER '{{username}}' WITH PASSWORD '{{password}}' NOSUPERUSER; GRANT SELECT ON ALL KEYSPACES TO {{username}};"]
      max_ttl               = 86400
      default_ttl           = 3600
      renew_statements      = []
      revocation_statements = ["DROP USER IF EXISTS {{username}};"]
      rollback_statements   = ["DROP USER IF EXISTS {{username}};"]
    }
  ]

  db_static_roles = [
    {
      backend             = var.cassandra_path
      name                = "cassandra-static-role"
      db_name             = "cassandra"
      username            = var.cassandra_username
      rotation_statements = ["ALTER ROLE {{username}} WITH PASSWORD = '{{password}}';"]
      rotation_period     = 86400


    }
  ]
}

