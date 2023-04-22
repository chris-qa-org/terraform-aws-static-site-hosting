resource "aws_cloudfront_origin_access_control" "static_site" {
  count = local.static_site_s3_enable_encryption && local.enable_cloudfront ? 1 : 0

  name                              = "${local.project_name}-static-site-s3"
  description                       = "${local.project_name} Static Site S3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_cache_policy" "static_site" {
  count = local.enable_cloudfront && local.cloudfront_static_site_default_cache_behaviour["cache_policy_id"] == null ? 1 : 0

  name        = "${local.project_name}-static-site-s3-default"
  comment     = "${local.project_name} Static Site S3 default"
  default_ttl = 86400
  max_ttl     = 31536000
  min_ttl     = 1

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_origin_request_policy" "static_site" {
  count = local.enable_cloudfront && local.cloudfront_static_site_default_cache_behaviour["origin_request_policy_id"] == null ? 1 : 0

  name    = "${local.project_name}-static-site-s3-default"
  comment = "${local.project_name} Static Site S3 default"

  cookies_config {
    cookie_behavior = "none"
  }
  headers_config {
    header_behavior = "whitelist"
    headers {
      items = [
        "Origin",
        "Access-Control-Request-Headers",
        "Access-Control-Request-Method"
      ]
    }
  }
  query_strings_config {
    query_string_behavior = "none"
  }
}

resource "aws_cloudfront_distribution" "static_site" {
  count = local.enable_cloudfront ? 1 : 0

  comment = "${local.project_name} Static Site"
  enabled = true

  web_acl_id = local.cloudfront_static_site_web_acl_id

  aliases = local.cloudfront_static_site_aliases

  viewer_certificate {
    acm_certificate_arn      = local.cloudfront_static_site_tls_certificate_arn == "" ? aws_acm_certificate.cloudfront_static_site[0].arn : local.cloudfront_static_site_tls_certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  origin {
    domain_name              = aws_s3_bucket.static_site.bucket_regional_domain_name
    origin_id                = local.cloudfront_static_site_s3_origin_id
    origin_access_control_id = local.static_site_s3_enable_encryption ? aws_cloudfront_origin_access_control.static_site[0].id : null
  }

  default_cache_behavior {
    allowed_methods  = local.cloudfront_static_site_default_cache_behaviour["allowed_methods"]
    cached_methods   = local.cloudfront_static_site_default_cache_behaviour["cached_methods"]
    target_origin_id = local.cloudfront_static_site_s3_origin_id
    cache_policy_id  = local.cloudfront_static_site_s3_cache_policy_id
    compress         = local.cloudfront_static_site_default_cache_behaviour["compress"]
    default_ttl      = local.cloudfront_static_site_default_cache_behaviour["default_ttl"]

    dynamic "lambda_function_association" {
      for_each = local.cloudfront_static_site_default_cache_behaviour["lambda_function_associations"]

      content {
        event_type   = lambda_function_association.value["event_type"]
        lambda_arn   = lambda_function_association.value["lambda_arn"]
        include_body = lambda_function_association.value["include_body"]
      }
    }

    dynamic "function_association" {
      for_each = local.cloudfront_static_site_default_cache_behaviour["lambda_function_associations"]

      content {
        event_type   = function_association.value["event_type"]
        function_arn = function_association.value["function_arn"]
      }
    }

    origin_request_policy_id   = local.cloudfront_static_site_s3_origin_request_policy_id
    realtime_log_config_arn    = local.cloudfront_static_site_default_cache_behaviour["realtime_log_config_arn"]
    response_headers_policy_id = local.cloudfront_static_site_default_cache_behaviour["response_headers_policy_id"]
    smooth_streaming           = local.cloudfront_static_site_default_cache_behaviour["smooth_streaming"]
    trusted_signers            = local.cloudfront_static_site_default_cache_behaviour["trusted_signers"]
    viewer_protocol_policy     = local.cloudfront_static_site_default_cache_behaviour["viewer_protocol_policy"]
  }

  dynamic "custom_error_response" {
    for_each = local.cloudfront_static_site_custom_error_responses

    content {
      error_code         = custom_error_response.key
      response_code      = custom_error_response.value["response_code"]
      response_page_path = custom_error_response.value["response_page_path"]
    }
  }

  default_root_object = local.cloudfront_static_site_default_root_object

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
      prefix          = "cloudfront/static_site"
    }
  }

  depends_on = [
    aws_acm_certificate_validation.cloudfront_static_site
  ]
}
