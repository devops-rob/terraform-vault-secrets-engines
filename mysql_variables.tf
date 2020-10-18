variable "mysql_path" {
  type        = string
  default     = "mysql"
  description = "Vault path where the Database secrets engine for mysql will be mounted."
}

variable "mysql_default_lease" {
  type        = number
  default     = 3600
  description = "Default lease for Database secrets engine for mysql."
}

variable "mysql_max_lease" {
  type        = number
  default     = 3600
  description = "Maximum lease for Database secrets engine for mysql."
}

variable "mysql_seal_wrapping" {
  type        = bool
  default     = true
  description = "Enable seal wrapping for the DB secrets engine for mysql."
}

variable "mysql_local_mount" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
}

variable "mysql_external_entropy_access" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
}

variable "mysql_allowed_roles" {
  type        = list(string)
  default     = null
  description = "A list of roles that are allowed to use this connection."
}

variable "mysql_root_rotation_statements" {
  type        = list(string)
  default     = null
  description = "A list of database statements to be executed to rotate the root user's credentials."
}

variable "mysql_verify_connection" {
  type        = bool
  default     = false
  description = "Whether the connection should be verified on initial configuration or not."
}

variable "mysql_connection_url" {
  type        = string
  default     = "localhost:3306"
  description = "A URL containing connection information."
}

variable "mysql_max_connection_lifetime" {
  type        = number
  default     = 360
  description = "The maximum number of seconds to keep a connection alive for."
}

variable "mysql_max_idle_connections" {
  type        = number
  default     = 360
  description = "The maximum number of idle connections to maintain."
}

variable "mysql_max_open_connections" {
  type        = number
  default     = 360
  description = "The maximum number of open connections to use."
}


