variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "static_site_s3_acl" {
  description = "Static Site S3 ACL"
  type        = string
  default     = "private"
}

variable "static_site_s3_enable_encryption" {
  description = "Static Site S3 Enable Encyption"
  type        = bool
  default     = true
}

variable "enable_s3_access_logs" {
  description = "enable_s3_access_logs"
  type        = bool
  default     = false
}

variable "s3_static_site_force_destroy" {
  description = "Force destroy Static Site S3 bucket"
  type        = bool
  default     = false
}

variable "s3_logs_force_destroy" {
  description = "Force destroy Logs S3 bucket"
  type        = bool
  default     = false
}
