resource "aws_s3_bucket" "site_redirect_to_www" {
  count = local.site_redirect_to_www ? 1 : 0

  bucket        = "${local.project_name}-static-site-www-redirect"
  force_destroy = local.s3_static_site_force_destroy
}

resource "aws_s3_bucket_versioning" "site_redirect_to_www" {
  count = local.site_redirect_to_www ? 1 : 0

  bucket = aws_s3_bucket.site_redirect_to_www[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "site_redirect_to_www" {
  count = local.enable_s3_access_logs && local.site_redirect_to_www ? 1 : 0

  bucket        = aws_s3_bucket.site_redirect_to_www[0].id
  target_bucket = aws_s3_bucket.logs[0].id
  target_prefix = "s3/static_site_www_redirect/"
}

resource "aws_s3_bucket_ownership_controls" "site_redirect_to_www" {
  bucket = aws_s3_bucket.site_redirect_to_www[0].id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "site_redirect_to_www" {
  count = local.site_redirect_to_www ? 1 : 0

  bucket = aws_s3_bucket.site_redirect_to_www[0].id
  acl    = local.static_site_s3_acl
}

resource "aws_s3_bucket_public_access_block" "site_redirect_to_www" {
  count = local.site_redirect_to_www ? 1 : 0

  bucket                  = aws_s3_bucket.site_redirect_to_www[0].id
  block_public_acls       = local.static_site_s3_acl == "public" ? false : true
  block_public_policy     = local.static_site_s3_acl == "public" ? false : true
  ignore_public_acls      = local.static_site_s3_acl == "public" ? false : true
  restrict_public_buckets = local.static_site_s3_acl == "public" ? false : true
}

resource "aws_s3_bucket_website_configuration" "site_redirect_to_www" {
  count = local.site_redirect_to_www ? 1 : 0

  bucket = aws_s3_bucket.site_redirect_to_www[0].id

  redirect_all_requests_to {
    host_name = "www.${local.site_host_name}"
    protocol  = "https"
  }
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "site_redirect_to_www" {
  count = local.static_site_s3_enable_encryption && local.site_redirect_to_www ? 1 : 0

  bucket = aws_s3_bucket.site_redirect_to_www[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "site_redirect_to_www" {
  count = local.site_redirect_to_www ? 1 : 0

  bucket = aws_s3_bucket.site_redirect_to_www[0].id
  policy = local.site_redirect_to_www_bucket_policy
}
