provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

# Set the following values using environment variables
variable "vault_token" {}
variable "rabbitmq_username" {}
variable "rabbitmq_password" {}

module "rabbitmq_defaults" {
  source = "../../"

  secrets_engines = ["rabbitmq"]

  rabbitmq_uri      = "http://localhost:15672"
  rabbitmq_username = var.rabbitmq_username
  rabbitmq_password = var.rabbitmq_password

  rabbitmq_backend_role_name = "example-virtual-host"
  rabbitmq_vhost             = "example-virtual-host"
  rabbitmq_read_permissions  = ".*"
}
