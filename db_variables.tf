variable "databases" {
  type        = list(string)
  default     = null
  description = "List of database secrets engines to enable."
}

variable "cassandra_path" {
  type        = string
  default     = "cassandra"
  description = "Vault path where the Database secrets engine for Cassandra will be mounted."
}

variable "cassandra_default_lease" {
  type        = number
  default     = 3600
  description = "Default lease for Database secrets engine for cassandra."
}

variable "cassandra_max_lease" {
  type        = number
  default     = 3600
  description = "Maximum lease for Database secrets engine for cassandra."
}

variable "cassandra_seal_wrapping" {
  type        = bool
  default     = true
  description = "Enable seal wrapping for the DB secrets engine for cassandra."
}

variable "cassandra_local_mount" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
}

variable "cassandra_external_entropy_access" {
  type        = bool
  default     = true
  description = "Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
}