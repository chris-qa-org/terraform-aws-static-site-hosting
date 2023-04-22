resource "aws_cloudfront_distribution" "site_www_redirect" {
  count = local.enable_cloudfront && local.site_redirect_to_www ? 1 : 0

  comment = "${local.project_name} Static Site redirect to www"
  enabled = true

  web_acl_id = local.cloudfront_static_site_web_acl_id

  aliases = [local.site_host_name]

  viewer_certificate {
    acm_certificate_arn      = local.cloudfront_static_site_tls_certificate_arn == "" ? aws_acm_certificate.cloudfront_static_site[0].arn : local.cloudfront_static_site_tls_certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  origin {
    domain_name = aws_s3_bucket_website_configuration.site_redirect_to_www[0].website_endpoint
    origin_id   = local.cloudfront_site_www_redirect_s3_origin_id

    custom_origin_config {
      origin_protocol_policy = "http-only"
      http_port              = "80"
      https_port             = "443"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = local.cloudfront_static_site_default_cache_behaviour["allowed_methods"]
    cached_methods   = local.cloudfront_static_site_default_cache_behaviour["cached_methods"]
    target_origin_id = local.cloudfront_site_www_redirect_s3_origin_id
    cache_policy_id  = local.cloudfront_static_site_s3_cache_policy_id
    compress         = local.cloudfront_static_site_default_cache_behaviour["compress"]
    default_ttl      = local.cloudfront_static_site_default_cache_behaviour["default_ttl"]

    origin_request_policy_id   = local.cloudfront_static_site_s3_origin_request_policy_id
    realtime_log_config_arn    = local.cloudfront_static_site_default_cache_behaviour["realtime_log_config_arn"]
    response_headers_policy_id = local.cloudfront_static_site_default_cache_behaviour["response_headers_policy_id"]
    smooth_streaming           = local.cloudfront_static_site_default_cache_behaviour["smooth_streaming"]
    trusted_signers            = local.cloudfront_static_site_default_cache_behaviour["trusted_signers"]
    viewer_protocol_policy     = local.cloudfront_static_site_default_cache_behaviour["viewer_protocol_policy"]
  }

  is_ipv6_enabled = local.cloudfront_static_site_is_ipv6_enabled
  http_version    = local.cloudfront_static_site_http_version

  restrictions {
    geo_restriction {
      restriction_type = local.cloudfront_static_site_restrictions["geo_restriction"]["restriction_type"]
      locations        = local.cloudfront_static_site_restrictions["geo_restriction"]["locations"]
    }
  }

  price_class = local.cloudfront_static_site_price_class

  dynamic "logging_config" {
    for_each = local.enable_cloudfront_static_site_logs ? [1] : []

    content {
      include_cookies = false
      bucket          = aws_s3_bucket.logs[0].bucket_domain_name
      prefix          = "cloudfront/static_site_www_redirect"
    }
  }

  depends_on = [
    aws_acm_certificate_validation.cloudfront_static_site
  ]
}
