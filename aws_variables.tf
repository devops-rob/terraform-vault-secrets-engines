# Variables for AWS secrets engine configuration

variable "aws_access_key" {
  type        = string
  default     = null
  description = "Access key for AWS account.  WARNING - this will be written to the state file in plain text. Set with AWS_ACCESS_KEY_ID to avoid this"
}

variable "aws_secret_key" {
  type        = string
  default     = null
  description = "Secret key for AWS account.  WARNING - this will be written to the state file in plain text. Set with AWS_SECRET_ACCESS_KEY to avoid this"
}

variable "aws_region" {
  type        = string
  default     = null
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

variable "aws_backend_role_name" {
  type        = string
  description = "Name for AWS backend role"
  default     = null
}

variable "aws_backend_role_cred_type" {
  type        = string
  default     = "iam_user"
  description = "type of credential to be used when retrieving credentials from the role. Must be one of iam_user, assumed_role, or federation_token"

  //  validation {
  //    condition     = ""
  //    error_message = "Must be one of iam_user, assumed_role, or federation_token"
  //  }
}

variable "aws_role_arns" {
  type        = list(string)
  default     = null
  description = "List of ARNs of the AWS roles this Vault role is allowed to assume. Required when credential_type is assumed_role and prohibited otherwise."
}

variable "aws_policy_arns" {
  type        = list(string)
  default     = null
  description = "List of AWS managed policy ARNs. The behavior depends on the credential type. With iam_user, the policies will be attached to IAM users when they are requested. With assumed_role and federation_token, the policy ARNs will act as a filter on what the credentials can do, similar to policy_document. When credential_type is iam_user or federation_token, at least one of policy_document or policy_arns must be specified"
}

variable "aws_policy_document" {
  type        = string
  default     = null
  description = "The IAM policy document for the role. The behavior depends on the credential type. With iam_user, the policy document will be attached to the IAM user generated and augment the permissions the IAM user has. With assumed_role and federation_token, the policy document will act as a filter on what the credentials can do, similar to policy_arns."
}

variable "aws_iam_groups" {
  type        = list(string)
  default     = null
  description = "A list of IAM group names. IAM users generated against this vault role will be added to these IAM Groups. For a credential type of assumed_role or federation_token, the policies sent to the corresponding AWS call (sts:AssumeRole or sts:GetFederation) will be the policies from each group in iam_groups combined with the policy_document and policy_arns parameters"
}

variable "aws_sts_default_ttl" {
  type        = number
  default     = 3600
  description = "The default TTL in seconds for STS credentials. Valid only when credential_type is one of assumed_role or federation_token."
}

variable "aws_sts_max_ttl" {
  type        = number
  default     = 3600
  description = "The max allowed TTL in seconds for STS credentials (credentials TTL are capped to max_sts_ttl). Valid only when credential_type is one of assumed_role or federation_token."
}