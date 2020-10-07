variable "secrets_engines" {
  type        = list(string)
  default     = ["kv"]
  description = "A list of secrets engines to enable"

//  validation {
//    condition     = "" # TODO - regex on all valid secrets engines
//    error_message = "Contains an invalid secrets engine"
//  }
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
  default     = false
  description = "Boolean flag that can be explicitly set to true to enforce local mount in HA environment"
}

variable "external_entropy_access" {
  type        = bool
  default     = false
  description = "Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source"
}

# AWS variables

variable "aws_access_key" {
  type = string
  default = null
  description = "Access key for AWS account.  WARNING - this will be written to the state file in plain text. Set with AWS_ACCESS_KEY_ID to avoid this"
}

variable "aws_secret_key" {
  type = string
  default = null
  description = "Secret key for AWS account.  WARNING - this will be written to the state file in plain text. Set with AWS_SECRET_ACCESS_KEY to avoid this"
}

variable "aws_region" {
  type = string
  default = null
  description = "AWS region.  Can also be set with the AWS_DEFAULT_REGION environment variable"
}

variable "aws_default_lease" {
  type        = number
  default     = 3600
  description = "Default lease for aws secrets engine backend. NOTE - This overrides the generic default lease set by default_lease"
}

variable "aws_max_lease" {
  type        = number
  default     = 3600
  description = "Maximum lease for aws secrets engine. NOTE - This overrides the generic default lease set by default_lease"
}
