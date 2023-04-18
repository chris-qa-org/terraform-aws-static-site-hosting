output "aws_s3_bucket_static_site" {
  value       = aws_s3_bucket.static_site
  description = "The Static Site S3 resource"
}

output "aws_s3_bucket_logs" {
  value       = local.create_logs_bucket ? aws_s3_bucket.logs[0] : null
  description = "The Logs S3 resource"
}
