resource "aws_route53_record" "cloudfront_static_site_tls_certificate_dns_validation" {
  for_each = local.cloudfront_static_site_tls_certificate_arn == "" && local.route53_zone_id != "" ? {
    for dvo in aws_acm_certificate.cloudfront_static_site[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  zone_id = data.aws_route53_zone.static_site[0].zone_id
  name    = each.value.name
  records = [each.value.record]
  type    = each.value.type
  ttl     = "86400"
}

resource "aws_route53_record" "static_site" {
  count = local.route53_zone_id != "" ? 1 : 0

  zone_id = data.aws_route53_zone.static_site[0].zone_id
  name    = local.site_host_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.static_site[0].domain_name
    zone_id                = aws_cloudfront_distribution.static_site[0].hosted_zone_id
    evaluate_target_health = true
  }
}
