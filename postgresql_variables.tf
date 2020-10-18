variable "postgresql_path" {
  type        = string
  default     = "postgresql"
  description = "Vault path where the Database secrets engine for postgresql will be mounted."
}

variable "postgresql_default_lease" {
  type        = number
  default     = 3600
  description = "Default lease for Database secrets engine for postgresql."
}

variable "postgresql_max_lease" {
  type        = number
  default     = 3600
  description = "Maximum lease for Database secrets engine for postgresql."
}

variable "postgresql_seal_wrapping" {
  type        = bool
  default     = true
  description = "Enable seal wrapping for the DB secrets engine for postgresql."
}

variable "postgresql_local_mount" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
}

variable "postgresql_external_entropy_access" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
}

variable "postgresql_allowed_roles" {
  type        = list(string)
  default     = null
  description = "A list of roles that are allowed to use this connection."
}

variable "postgresql_root_rotation_statements" {
  type        = list(string)
  default     = null
  description = "A list of database statements to be executed to rotate the root user's credentials."
}

variable "postgresql_verify_connection" {
  type        = bool
  default     = false
  description = "Whether the connection should be verified on initial configuration or not."
}

variable "postgresql_connection_url" {
  type        = string
  default     = "localhost:5432"
  description = "A URL containing connection information."
}

variable "postgresql_max_connection_lifetime" {
  type        = number
  default     = 360
  description = "The maximum number of seconds to keep a connection alive for."
}

variable "postgresql_max_idle_connections" {
  type        = number
  default     = 360
  description = "The maximum number of idle connections to maintain."
}

variable "postgresql_max_open_connections" {
  type        = number
  default     = 360
  description = "The maximum number of open connections to use."
}


