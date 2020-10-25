provider "vault" {
  address = "http://localhost:8200"
  token   = var.vault_token
}

variable "vault_token" {}
variable "rabbitmq_username" {}
variable "rabbitmq_password" {}

module "rabbitmq_defaults" {
  source = "../../"

  secrets_engines            = ["rabbitmq"]
  rabbitmq_username          = var.rabbitmq_username
  rabbitmq_password          = var.rabbitmq_password
  rabbitmq_backend_role_name = "test"
  rabbitmq_uri               = "http://localhost:15672"
  rabbitmq_tags              = "administrator"

}
