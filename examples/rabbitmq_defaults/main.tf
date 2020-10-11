provider "vault" {
  address = "http://localhost:8200"
  token   = "root"
}

module "rabbitmq_defaults" {
  source = "../../"

  secrets_engines   = ["rabbitmq"]
  rabbitmq_username = "user"
  rabbitmq_password = "password"
  rabbitmq_backend_role_name = "test"
}
