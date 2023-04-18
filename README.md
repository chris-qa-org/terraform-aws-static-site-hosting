# Terraform AWS Static Site Hosting

[![Terraform CI](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-terraform.yml/badge.svg?branch=main)](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-terraform.yml?branch=main)
[![Tflint](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-tflint.yml/badge.svg?branch=main)](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-tflint.yml?branch=main)
[![Tfsec](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-tfsec.yml/badge.svg?branch=main)](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/actions/workflows/continuous-integration-tfsec.yml?branch=main)
[![GitHub release](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/releases)](https://github.com/chris-qa-org/terraform-aws-static-site-hosting/releases)

This module creates and manages Static Site hosting on AWS, mainly using S3 and Cloudfront.

## Usage

Example module usage:

```hcl
module "static_site_hosting" {
  source  = "github.com/chris-qa-org/terraform-aws-static-site-hosting?ref=v0.1.0"

  project_name = "my-project"

  static_site_s3_acl               = "private"
  static_site_s3_enable_encryption = true
  # enable_s3_access_logs           = false
  # s3_static_site_force_destroy    = false
  # s3_logs_force_destroy           = false
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.63.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_logging.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_policy.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.static_site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_s3_access_logs"></a> [enable\_s3\_access\_logs](#input\_enable\_s3\_access\_logs) | enable\_s3\_access\_logs | `bool` | `false` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project Name | `string` | n/a | yes |
| <a name="input_s3_logs_force_destroy"></a> [s3\_logs\_force\_destroy](#input\_s3\_logs\_force\_destroy) | Force destroy Logs S3 bucket | `bool` | `false` | no |
| <a name="input_s3_static_site_force_destroy"></a> [s3\_static\_site\_force\_destroy](#input\_s3\_static\_site\_force\_destroy) | Force destroy Static Site S3 bucket | `bool` | `false` | no |
| <a name="input_static_site_s3_acl"></a> [static\_site\_s3\_acl](#input\_static\_site\_s3\_acl) | Static Site S3 ACL | `string` | `"private"` | no |
| <a name="input_static_site_s3_enable_encryption"></a> [static\_site\_s3\_enable\_encryption](#input\_static\_site\_s3\_enable\_encryption) | Static Site S3 Enable Encyption | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_s3_bucket_logs"></a> [aws\_s3\_bucket\_logs](#output\_aws\_s3\_bucket\_logs) | The Logs S3 resource |
| <a name="output_aws_s3_bucket_static_site"></a> [aws\_s3\_bucket\_static\_site](#output\_aws\_s3\_bucket\_static\_site) | The Static Site S3 resource |
<!-- END_TF_DOCS -->
