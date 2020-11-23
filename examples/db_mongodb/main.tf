provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

variable "mongodb_path" {
  default = "mongodb"
}

variable "vault_token" {}
variable "mongodb_user" {}
variable "mongodb_password" {}

module "mongodb_static" {
  source          = "../../"
  secrets_engines = ["db"]

  databases = [
    "mongodb"
  ]

  mongodb_path = var.mongodb_path

  mongodb_allowed_roles       = ["*"]
  mongodb_connection_endpoint = "localhost:27017"

  mongodb_username = var.mongodb_user
  mongodb_password = var.mongodb_password
  mongodb_tls      = false

  db_roles = [
    {
      backend               = var.mongodb_path
      name                  = "mongodb-role"
      db_name               = "mongodb"
      creation_statements   = ["{ \"db\": \"admin\", \"roles\": [{ \"role\": \"readWrite\" }, {\"role\": \"read\", \"db\": \"foo\"}] }"]
      max_ttl               = 86400
      default_ttl           = 3600
      renew_statements      = []
      revocation_statements = []
      rollback_statements   = []
    }
  ]

  db_static_roles = [
    {
      backend             = var.mongodb_path
      name                = "mongodb-static-role"
      db_name             = "mongodb"
      username            = var.mongodb_user
      rotation_statements = ["{\"db\": \"admin\"}"]
      rotation_period     = 86400


    }
  ]
}

