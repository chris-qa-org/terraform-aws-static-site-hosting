resource "aws_s3_bucket" "static_site" {
  bucket        = "${local.project_name}-static-site"
  force_destroy = local.s3_static_site_force_destroy
}

resource "aws_s3_bucket_versioning" "static_site" {
  bucket = aws_s3_bucket.static_site.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "static_site" {
  count = local.enable_s3_access_logs ? 1 : 0

  bucket        = aws_s3_bucket.static_site.id
  target_bucket = aws_s3_bucket.logs[0].id
  target_prefix = "s3/static_site/"
}

resource "aws_s3_bucket_acl" "static_site" {
  bucket = aws_s3_bucket.static_site.id
  acl    = local.static_site_s3_acl
}

resource "aws_s3_bucket_public_access_block" "static_site" {
  bucket                  = aws_s3_bucket.static_site.id
  block_public_acls       = local.static_site_s3_acl == "public" ? false : true
  block_public_policy     = local.static_site_s3_acl == "public" ? false : true
  ignore_public_acls      = local.static_site_s3_acl == "public" ? false : true
  restrict_public_buckets = local.static_site_s3_acl == "public" ? false : true
}

resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.static_site.bucket

  index_document {
    suffix = "index.html"
  }
}

#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "static_site" {
  count = local.static_site_s3_enable_encryption ? 1 : 0

  bucket = aws_s3_bucket.static_site.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "static_site" {
  bucket = aws_s3_bucket.static_site.id
  policy = local.static_site_bucket_policy
}
