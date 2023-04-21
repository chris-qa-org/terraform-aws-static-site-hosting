variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "site_host_name" {
  description = "Site Host Name. This will be used for Certificate generation and CloudFront aliases"
  type        = string
  default     = ""
}

variable "route53_zone_id" {
  description = "Route53 zone id. If provided, the certificate validation records and site records will be created in that zone"
  type        = string
  default     = ""
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
  description = "Enable S3 access logs"
  type        = bool
  default     = true
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

variable "enable_cloudfront" {
  description = "Enable creation of CloudFront Distribution"
  type        = bool
  default     = true
}

variable "cloudfront_static_site_web_acl_id" {
  description = "CloudFront static site Web ACL id"
  type        = string
  default     = null
}

variable "cloudfront_static_site_tls_certificate_arn" {
  description = "CloudFront static site TLS Certificate ARN. This is not required, as one will be created based on the `site_url`. Use this only if the created certificate is not sufficient."
  type        = string
  default     = ""
}

variable "cloudfront_static_site_default_cache_behaviour" {
  description = "Default cache behaviour block for the Static Site CloudFront Distribution"
  type = object({
    allowed_methods = optional(list(string), ["GET", "HEAD"])
    cached_methods  = optional(list(string), ["GET", "HEAD"])
    cache_policy_id = optional(string, null)
    compress        = optional(bool, true)
    default_ttl     = optional(number, 86400)
    lambda_function_associations = optional(map(object({
      event_type   = string
      lambda_arn   = string
      include_body = optional(bool, false)
    })), {})
    function_associations = optional(map(object({
      event_type   = string
      function_arn = string
    })), {})
    max_ttl                    = optional(number, 31536000)
    min_ttl                    = optional(number, 1)
    origin_request_policy_id   = optional(string, null)
    realtime_log_config_arn    = optional(string, null)
    response_headers_policy_id = optional(string, null)
    smooth_streaming           = optional(bool, false)
    trusted_signers            = optional(list(string), null)
    viewer_protocol_policy     = optional(string, "redirect-to-https")
  })
  default = {}
}

variable "cloudfront_static_site_custom_error_responses" {
  description = "CloudFront Static Site custom error responses"
  type = map(object({
    response_code      = string
    response_page_path = string
  }))
  default = {
    "404" = {
      response_code      = "404",
      response_page_path = "/404.html"
    }
  }
}

variable "cloudfront_static_site_default_root_object" {
  description = "CloudFront Static Site default root object"
  type        = string
  default     = "index.html"
}

variable "cloudfront_static_site_price_class" {
  description = "CloudFront Static Site price class"
  type        = string
  default     = "PriceClass_100"
}

variable "cloudfront_static_site_restrictions" {
  description = "Cloudfront Static Site restrictions block"
  type = object({
    geo_restriction = optional(object({
      restriction_type = string
      locations        = list(string)
    }))
  })
  default = {
    geo_restriction = {
      restriction_type = "none"
      locations        = []
    }
  }
}

variable "cloudfront_static_site_is_ipv6_enabled" {
  description = "CloudFront Static Site enable ipv6"
  type        = bool
  default     = true
}

variable "cloudfront_static_site_http_version" {
  description = "CloudFront Static Site http version"
  type        = string
  default     = "http2"
}

variable "enable_cloudfront_static_site_logs" {
  description = "Enable CloudFront Staci Site logging to the logs bucket"
  type        = bool
  default     = true
}
