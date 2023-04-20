resource "aws_acm_certificate" "cloudfront_static_site" {
  provider = aws.useast1

  count = local.cloudfront_static_site_tls_certificate_arn == "" ? 1 : 0

  domain_name = local.site_host_name

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
