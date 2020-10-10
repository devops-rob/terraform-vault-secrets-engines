variable "consul_address" {
  type        = string
  default     = "localhost:8500"
  description = "The address of the Consul server."
}

variable "consul_use_https" {
  type        = bool
  default     = true
  description = "Use HTTPS to connect to Consul"
}

locals {
  http   = "http"
  https  = "https"
  scheme = var.consul_use_https ? local.https : local.http
}

variable "consul_token" {
  type        = string
  default     = null
  description = "The Consul ACL token."
}

variable "consul_default_lease" {
  type        = number
  default     = 3600
  description = "Default lease for Consul secrets engine"
}

variable "consul_max_lease" {
  type        = number
  default     = 3600
  description = "Maximum lease for Consul secrets engine"
}

variable "consul_backend_role_name" {
  type        = string
  default     = null
  description = "Name for Consul role"
}

variable "consul_policies" {
  type        = list(string)
  default     = null
  description = "List of consul policies that will be attached to generated ACL tokens"
}

variable "consul_local_token" {
  type        = bool
  default     = false
  description = "Specify if Consul ACL token should be kept locally."
}

variable "consul_token_type" {
  type        = string
  default     = "Client"
  description = "Consul token type"

  validation {
    condition     = can(contains(["Management", "Client"], var.consul_token_type))
    error_message = "Must be one of Management or Client."
  }
}