locals {
  project_name         = var.project_name
  account_id           = data.aws_caller_identity.current.account_id
  site_host_name       = var.site_host_name
  site_redirect_to_www = var.site_redirect_to_www
  route53_zone_id      = var.route53_zone_id

  s3_bucket_policy_statement_enforce_tls_path    = "${path.module}/policies/s3-bucket-policy-statements/enforce-tls.json.tpl"
  s3_bucket_policy_statement_log_delivery_access = "${path.module}/policies/s3-bucket-policy-statements/log-delivery-access.json.tpl"
  s3_bucket_policy_statement_cloudfront_read     = "${path.module}/policies/s3-bucket-policy-statements/cloudfront-read.json.tpl"
  s3_bucket_policy_path                          = "${path.module}/policies/s3-bucket-policy.json.tpl"

  static_site_s3_acl               = var.static_site_s3_acl
  static_site_s3_enable_encryption = var.static_site_s3_enable_encryption
  static_site_bucket_enforce_tls_statement = templatefile(
    local.s3_bucket_policy_statement_enforce_tls_path,
    {
      bucket_arn = aws_s3_bucket.static_site.arn
    }
  )
  static_site_bucket_cloudfront_read_statement = templatefile(
    local.s3_bucket_policy_statement_cloudfront_read,
    {
      bucket_arn     = aws_s3_bucket.static_site.arn,
      cloudfront_arn = aws_cloudfront_distribution.static_site[0].arn
    }
  )
  static_site_bucket_policy = templatefile(
    local.s3_bucket_policy_path,
    {
      statement = <<EOT
      [
      ${local.static_site_bucket_enforce_tls_statement},
      ${local.static_site_bucket_cloudfront_read_statement}
      ]
      EOT
    }
  )
  s3_static_site_force_destroy = var.s3_static_site_force_destroy

  site_redirect_to_www_bucket_enforce_tls_statement = local.site_redirect_to_www ? templatefile(
    local.s3_bucket_policy_statement_enforce_tls_path,
    {
      bucket_arn = aws_s3_bucket.site_redirect_to_www[0].arn
    }
  ) : ""
  site_redirect_to_www_bucket_cloudfront_read_statement = local.site_redirect_to_www ? templatefile(
    local.s3_bucket_policy_statement_cloudfront_read,
    {
      bucket_arn     = aws_s3_bucket.site_redirect_to_www[0].arn,
      cloudfront_arn = aws_cloudfront_distribution.site_www_redirect[0].arn
    }
  ) : ""
  site_redirect_to_www_bucket_policy = templatefile(
    local.s3_bucket_policy_path,
    {
      statement = <<EOT
      [
      ${local.site_redirect_to_www_bucket_enforce_tls_statement},
      ${local.site_redirect_to_www_bucket_cloudfront_read_statement}
      ]
      EOT
    }
  )

  enable_cloudfront                                  = var.enable_cloudfront
  cloudfront_static_site_s3_origin_id                = "${local.project_name}-static-site-s3"
  cloudfront_site_www_redirect_s3_origin_id          = "${local.project_name}-static-site-s3-redirect-to-www"
  cloudfront_static_site_s3_cache_policy_id          = local.enable_cloudfront && local.cloudfront_static_site_default_cache_behaviour["cache_policy_id"] == null ? aws_cloudfront_cache_policy.static_site[0].id : local.cloudfront_static_site_default_cache_behaviour["cache_policy_id"]
  cloudfront_static_site_s3_origin_request_policy_id = local.enable_cloudfront && local.cloudfront_static_site_default_cache_behaviour["origin_request_policy_id"] == null ? aws_cloudfront_origin_request_policy.static_site[0].id : local.cloudfront_static_site_default_cache_behaviour["origin_request_policy_id"]
  cloudfront_static_site_aliases                     = local.site_redirect_to_www ? ["www.${local.site_host_name}"] : [local.site_host_name]
  cloudfront_static_site_web_acl_id                  = var.cloudfront_static_site_web_acl_id
  cloudfront_static_site_tls_certificate_arn         = var.cloudfront_static_site_tls_certificate_arn
  cloudfront_static_site_custom_error_responses      = var.cloudfront_static_site_custom_error_responses
  cloudfront_static_site_default_root_object         = var.cloudfront_static_site_default_root_object
  cloudfront_static_site_price_class                 = var.cloudfront_static_site_price_class
  cloudfront_static_site_restrictions                = var.cloudfront_static_site_restrictions
  cloudfront_static_site_is_ipv6_enabled             = var.cloudfront_static_site_is_ipv6_enabled
  cloudfront_static_site_http_version                = var.cloudfront_static_site_http_version
  cloudfront_static_site_default_cache_behaviour     = var.cloudfront_static_site_default_cache_behaviour

  enable_s3_access_logs              = var.enable_s3_access_logs
  enable_cloudfront_static_site_logs = var.enable_cloudfront_static_site_logs
  create_logs_bucket                 = local.enable_s3_access_logs || local.enable_cloudfront_static_site_logs
  logs_bucket_enforce_tls_statement = local.create_logs_bucket ? templatefile(
    local.s3_bucket_policy_statement_enforce_tls_path,
    {
      bucket_arn = aws_s3_bucket.logs[0].arn
    }
  ) : ""
  logs_bucket_log_delivery_access_statement = local.create_logs_bucket ? templatefile(
    local.s3_bucket_policy_statement_log_delivery_access,
    {
      log_bucket_arn = aws_s3_bucket.logs[0].arn,
      source_bucket_arns = jsonencode([
        aws_s3_bucket.static_site.arn
      ]),
      account_id = local.account_id
    }
  ) : ""
  logs_bucket_policy = templatefile(
    local.s3_bucket_policy_path,
    {
      statement = <<EOT
      [
      ${local.logs_bucket_enforce_tls_statement},
      ${local.logs_bucket_log_delivery_access_statement}
      ]
      EOT
    }
  )
  s3_logs_force_destroy = var.s3_logs_force_destroy
}
