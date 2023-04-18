locals {
  project_name = var.project_name
  account_id   = data.aws_caller_identity.current.account_id

  s3_bucket_policy_statement_enforce_tls_path    = "${path.module}/policies/s3-bucket-policy-statements/enforce-tls.json.tpl"
  s3_bucket_policy_statement_log_delivery_access = "${path.module}/policies/s3-bucket-policy-statements/log-delivery-access.json.tpl"
  s3_bucket_policy_path                          = "${path.module}/policies/s3-bucket-policy.json.tpl"

  static_site_s3_acl               = var.static_site_s3_acl
  static_site_s3_enable_encryption = var.static_site_s3_enable_encryption
  static_site_bucket_enforce_tls_statement = templatefile(
    local.s3_bucket_policy_statement_enforce_tls_path,
    {
      bucket_arn = aws_s3_bucket.static_site.arn
    }
  )
  static_site_bucket_policy = templatefile(
    local.s3_bucket_policy_path,
    {
      statement = <<EOT
      [
      ${local.static_site_bucket_enforce_tls_statement}
      ]
      EOT
    }
  )
  s3_static_site_force_destroy = var.s3_static_site_force_destroy

  enable_s3_access_logs = var.enable_s3_access_logs
  create_logs_bucket    = local.enable_s3_access_logs
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
