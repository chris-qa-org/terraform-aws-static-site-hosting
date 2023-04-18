resource "aws_s3_bucket" "logs" {
  count = local.create_logs_bucket ? 1 : 0

  bucket        = "${local.project_name}-logs"
  force_destroy = local.s3_logs_force_destroy
}

resource "aws_s3_bucket_versioning" "logs" {
  count = local.create_logs_bucket ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "logs" {
  count = local.enable_s3_access_logs ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_public_access_block" "logs" {
  count = local.create_logs_bucket ? 1 : 0

  bucket                  = aws_s3_bucket.logs[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  count = local.create_logs_bucket ? 1 : 0

  bucket = aws_s3_bucket.logs[0].bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "logs" {
  count = local.create_logs_bucket ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id
  policy = local.logs_bucket_policy
}
