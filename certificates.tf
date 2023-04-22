resource "aws_acm_certificate" "cloudfront_static_site" {
  provider = aws.useast1

  count = local.cloudfront_static_site_tls_certificate_arn == "" ? 1 : 0

  domain_name = local.site_host_name
  subject_alternative_names = local.site_redirect_to_www ? [
    "www.${local.site_host_name}"
  ] : []

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cloudfront_static_site" {
  provider = aws.useast1

  count = local.cloudfront_static_site_tls_certificate_arn == "" && local.route53_zone_id != "" ? 1 : 0

  certificate_arn         = aws_acm_certificate.cloudfront_static_site[0].arn
  validation_record_fqdns = [for record in aws_route53_record.cloudfront_static_site_tls_certificate_dns_validation : record.fqdn]
}
