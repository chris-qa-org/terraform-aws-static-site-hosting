data "aws_caller_identity" "current" {}

data "aws_canonical_user_id" "current" {}

data "aws_route53_zone" "static_site" {
  count = local.route53_zone_id != "" ? 1 : 0

  zone_id = local.route53_zone_id
}
