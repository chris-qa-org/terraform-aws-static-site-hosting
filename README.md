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

  environment = "dev/staging/test/pre-prod/prod/post-prod"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.4 |

## Providers

No providers.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_environment"></a> [environment](#output\_environment) | n/a |
<!-- END_TF_DOCS -->
