variable "elasticsearch_path" {
  type        = string
  default     = "elasticsearch"
  description = "Vault path where the Database secrets engine for elasticsearch will be mounted."
}

variable "elasticsearch_default_lease" {
  type        = number
  default     = 3600
  description = "Default lease for Database secrets engine for elasticsearch."
}

variable "elasticsearch_max_lease" {
  type        = number
  default     = 3600
  description = "Maximum lease for Database secrets engine for elasticsearch."
}

variable "elasticsearch_seal_wrapping" {
  type        = bool
  default     = true
  description = "Enable seal wrapping for the DB secrets engine for elasticsearch."
}

variable "elasticsearch_local_mount" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
}

variable "elasticsearch_external_entropy_access" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
}

variable "elasticsearch_allowed_roles" {
  type        = list(string)
  default     = null
  description = "A list of roles that are allowed to use this connection."
}

variable "elasticsearch_root_rotation_statements" {
  type        = string
  default     = null
  description = "A list of database statements to be executed to rotate the root user's credentials."
}

variable "elasticsearch_verify_connection" {
  type        = bool
  default     = false
  description = "Whether the connection should be verified on initial configuration or not."
}

variable "elasticsearch_url" {
  type        = string
  default     = "localhost:9300"
  description = "A URL containing connection information."
}

variable "elasticsearch_username" {
  type        = string
  default     = null
  description = "The username to be used in the connection."
}

variable "elasticsearch_password" {
  type        = string
  default     = null
  description = "The password to be used in the connection."
}

