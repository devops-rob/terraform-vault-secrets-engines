variable "secrets_engines" {
  type        = list(string)
  default     = null
  description = "A list of secrets engines to enable"

  validation {
    condition = can(contains(
      [
        "aws",
        "azure",
        "gcp",
        "consul",
        "pki",
        "transit",
        "rabbitmq",
        "ssh",
        "db"
    ], var.secrets_engines))
    error_message = "Invalid secrets engines."
  }
}

variable "default_lease" {
  type        = number
  default     = 3600
  description = "Default lease for all secrets engines"
}

variable "max_lease" {
  type        = number
  default     = 3600
  description = "Maximum lease for all secrets engines"
}

variable "seal_wrap" {
  type        = bool
  default     = true
  description = "Enable seal wrapping for secrets engines"
}

variable "local_mount" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
}

variable "external_entropy_access" {
  type        = bool
  default     = false
  description = "Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
}

variable "vault_token" {
  type        = string
  default     = null
  description = "Vault token to use for authentication."
}

variable "vault_addr" {
  type        = string
  default     = "http://localhost:8200"
  description = "Vault address."
}


