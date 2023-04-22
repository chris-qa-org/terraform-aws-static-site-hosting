# Terraform AWS Static Site Hosting

[![Terraform CI](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-terraform.yml/badge.svg?branch=main)](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-terraform.yml?branch=main)
[![Tflint](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-tflint.yml/badge.svg?branch=main)](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-tflint.yml?branch=main)
[![Tfsec](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-tfsec.yml/badge.svg?branch=main)](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-tfsec.yml?branch=main)
[![GitHub release](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/releases)](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/releases)

This module creates and manages Static Site hosting on AWS, mainly using S3 and Cloudfront.

## Usage

Example module usage:

```hcl
# Because this module _might_ utilise CloudFront resources,
# which are required to be launched in the us-east-1 region,
# an AWS provider with the 'us-east-1' region must be provided
#
# It's not yet possible to conditionally require a regional AWS provider
provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
}

module "static_site_hosting" {
  source  = "github.com/chris-qa-org/terraform-aws-static-site-hosting?ref=v0.1.0"

  project_name = "my-project"

  # site_host_name = ""

  #  providers = {
  #    aws.useast1 = aws.useast1
  #  }

  # static_site_s3_acl               = "private"
  # static_site_s3_enable_encryption = true
  # enable_s3_access_logs            = false
  # s3_static_site_force_destroy     = false
  # s3_logs_force_destroy            = false

  # enable_cloudfront                          = true
  # cloudfront_static_site_web_acl_id          = null
  # cloudfront_static_site_tls_certificate_arn = ""
  # cloudfront_static_site_default_cache_behaviour = {}
  # cloudfront_static_site_custom_error_responses = {
  #    "404" = {
  #      response_code      = "404",
  #      response_page_path = "/404.html"
  #   }
  # }
  # cloudfront_static_site_default_root_object = "index.html"
  # cloudfront_static_site_price_class         = "PriceClass_100"
  # cloudfront_static_site_restrictions = {
  #   geo_restriction = {
  #     restriction_type = "none"
  #     locations        = []
  #   }
  # }
  # cloudfront_static_site_is_ipv6_enabled = true
  # cloudfront_static_site_http_version = "http2"
  # enable_cloudfront_static_site_logs = true
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.64.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.64.0 |
| <a name="provider_aws.useast1"></a> [aws.useast1](#provider\_aws.useast1) | 4.64.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cloudfront_static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.cloudfront_static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_cloudfront_cache_policy.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_cache_policy) | resource |
| [aws_cloudfront_distribution.site_www_redirect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_distribution.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_cloudfront_origin_request_policy.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_request_policy) | resource |
| [aws_route53_record.cloudfront_static_site_tls_certificate_dns_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.static_site_www_redirect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.site_redirect_to_www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.cloudfront_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.site_redirect_to_www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_logging.site_redirect_to_www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_logging.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_ownership_controls.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.site_redirect_to_www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.site_redirect_to_www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.site_redirect_to_www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.site_redirect_to_www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.site_redirect_to_www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.site_redirect_to_www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_s3_bucket_website_configuration.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_s3_object.static_site_index](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_canonical_user_id.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/canonical_user_id) | data source |
| [aws_route53_zone.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudfront_static_site_custom_error_responses"></a> [cloudfront\_static\_site\_custom\_error\_responses](#input\_cloudfront\_static\_site\_custom\_error\_responses) | CloudFront Static Site custom error responses | <pre>map(object({<br>    response_code      = string<br>    response_page_path = string<br>  }))</pre> | <pre>{<br>  "404": {<br>    "response_code": "404",<br>    "response_page_path": "/404.html"<br>  }<br>}</pre> | no |
| <a name="input_cloudfront_static_site_default_cache_behaviour"></a> [cloudfront\_static\_site\_default\_cache\_behaviour](#input\_cloudfront\_static\_site\_default\_cache\_behaviour) | Default cache behaviour block for the Static Site CloudFront Distribution | <pre>object({<br>    allowed_methods = optional(list(string), ["GET", "HEAD"])<br>    cached_methods  = optional(list(string), ["GET", "HEAD"])<br>    cache_policy_id = optional(string, null)<br>    compress        = optional(bool, true)<br>    default_ttl     = optional(number, 0)<br>    lambda_function_associations = optional(map(object({<br>      event_type   = string<br>      lambda_arn   = string<br>      include_body = optional(bool, false)<br>    })), {})<br>    function_associations = optional(map(object({<br>      event_type   = string<br>      function_arn = string<br>    })), {})<br>    max_ttl                    = optional(number, 31536000)<br>    min_ttl                    = optional(number, 1)<br>    origin_request_policy_id   = optional(string, null)<br>    realtime_log_config_arn    = optional(string, null)<br>    response_headers_policy_id = optional(string, null)<br>    smooth_streaming           = optional(bool, false)<br>    trusted_signers            = optional(list(string), null)<br>    viewer_protocol_policy     = optional(string, "redirect-to-https")<br>  })</pre> | `{}` | no |
| <a name="input_cloudfront_static_site_default_root_object"></a> [cloudfront\_static\_site\_default\_root\_object](#input\_cloudfront\_static\_site\_default\_root\_object) | CloudFront Static Site default root object | `string` | `"index.html"` | no |
| <a name="input_cloudfront_static_site_http_version"></a> [cloudfront\_static\_site\_http\_version](#input\_cloudfront\_static\_site\_http\_version) | CloudFront Static Site http version | `string` | `"http2"` | no |
| <a name="input_cloudfront_static_site_is_ipv6_enabled"></a> [cloudfront\_static\_site\_is\_ipv6\_enabled](#input\_cloudfront\_static\_site\_is\_ipv6\_enabled) | CloudFront Static Site enable ipv6 | `bool` | `true` | no |
| <a name="input_cloudfront_static_site_price_class"></a> [cloudfront\_static\_site\_price\_class](#input\_cloudfront\_static\_site\_price\_class) | CloudFront Static Site price class | `string` | `"PriceClass_100"` | no |
| <a name="input_cloudfront_static_site_restrictions"></a> [cloudfront\_static\_site\_restrictions](#input\_cloudfront\_static\_site\_restrictions) | Cloudfront Static Site restrictions block | <pre>object({<br>    geo_restriction = optional(object({<br>      restriction_type = string<br>      locations        = list(string)<br>    }))<br>  })</pre> | <pre>{<br>  "geo_restriction": {<br>    "locations": [],<br>    "restriction_type": "none"<br>  }<br>}</pre> | no |
| <a name="input_cloudfront_static_site_tls_certificate_arn"></a> [cloudfront\_static\_site\_tls\_certificate\_arn](#input\_cloudfront\_static\_site\_tls\_certificate\_arn) | CloudFront static site TLS Certificate ARN. This is not required, as one will be created based on the `site_url`. Use this only if the created certificate is not sufficient. | `string` | `""` | no |
| <a name="input_cloudfront_static_site_web_acl_id"></a> [cloudfront\_static\_site\_web\_acl\_id](#input\_cloudfront\_static\_site\_web\_acl\_id) | CloudFront static site Web ACL id | `string` | `null` | no |
| <a name="input_enable_cloudfront"></a> [enable\_cloudfront](#input\_enable\_cloudfront) | Enable creation of CloudFront Distribution | `bool` | `true` | no |
| <a name="input_enable_cloudfront_static_site_logs"></a> [enable\_cloudfront\_static\_site\_logs](#input\_enable\_cloudfront\_static\_site\_logs) | Enable CloudFront Staci Site logging to the logs bucket | `bool` | `true` | no |
| <a name="input_enable_s3_access_logs"></a> [enable\_s3\_access\_logs](#input\_enable\_s3\_access\_logs) | Enable S3 access logs | `bool` | `true` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project Name | `string` | n/a | yes |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | Route53 zone id. If provided, the certificate validation records and site records will be created in that zone | `string` | `""` | no |
| <a name="input_s3_logs_force_destroy"></a> [s3\_logs\_force\_destroy](#input\_s3\_logs\_force\_destroy) | Force destroy Logs S3 bucket | `bool` | `false` | no |
| <a name="input_s3_static_site_force_destroy"></a> [s3\_static\_site\_force\_destroy](#input\_s3\_static\_site\_force\_destroy) | Force destroy Static Site S3 bucket | `bool` | `false` | no |
| <a name="input_site_host_name"></a> [site\_host\_name](#input\_site\_host\_name) | Site Host Name. This will be used for Certificate generation and CloudFront aliases | `string` | `""` | no |
| <a name="input_site_redirect_to_www"></a> [site\_redirect\_to\_www](#input\_site\_redirect\_to\_www) | Conditionally redirect to www.<site\_host\_name> | `bool` | `false` | no |
| <a name="input_static_site_s3_acl"></a> [static\_site\_s3\_acl](#input\_static\_site\_s3\_acl) | Static Site S3 ACL | `string` | `"private"` | no |
| <a name="input_static_site_s3_enable_encryption"></a> [static\_site\_s3\_enable\_encryption](#input\_static\_site\_s3\_enable\_encryption) | Static Site S3 Enable Encyption | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_s3_bucket_logs"></a> [aws\_s3\_bucket\_logs](#output\_aws\_s3\_bucket\_logs) | The Logs S3 resource |
| <a name="output_aws_s3_bucket_static_site"></a> [aws\_s3\_bucket\_static\_site](#output\_aws\_s3\_bucket\_static\_site) | The Static Site S3 resource |
<!-- END_TF_DOCS -->
