variable "rabbitmq_uri" {
  type        = string
  default     = "http://localhost:15672"
  description = "Connection URI for RabbitMQ instance"
}

variable "rabbitmq_password" {
  type        = string
  default     = null
  description = "Password for RabbitMQ instance."
}

variable "rabbitmq_username" {
  type        = string
  default     = null
  description = "Username for RabbitMQ instance."
}

variable "rabbitmq_verify_connection" {
  type        = bool
  default     = false
  description = "Specifies whether to verify connection URI, username, and password."
}

variable "rabbitmq_default_ttl" {
  type        = number
  default     = 3600
  description = "Default TTL for RabbitMQ."
}

variable "rabbitmq_maximum_ttl" {
  type        = number
  default     = 3600
  description = "Mai TTL for RabbitMQ."
}

variable "rabbitmq_backend_role_name" {
  type        = string
  default     = null
  description = "Name of RabbitMQ backend role."
}

variable "rabbitmq_vhost" {
  type        = string
  default     = "/"
  description = "RabbitMQ vhost that generated credentials will have access to."
}

variable "rabbitmq_read_permissions" {
  type        = string
  default     = ""
  description = "List of resources to grant read permissions to."
}

variable "rabbitmq_write_permissions" {
  type        = string
  default     = ""
  description = "List of resources to grant write permissions to."
}

variable "rabbitmq_configure_permissions" {
  type        = string
  default     = ""
  description = "List of resources to grant configure permissions to."
}

variable "rabbitmq_tags" {
  type        = string
  default     = null
  description = "Comma separated list of RabbitMQ tags to assign to generated user"
}
