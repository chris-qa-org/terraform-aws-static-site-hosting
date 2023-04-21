{
  "Principal": {
    "Service": "cloudfront.amazonaws.com"
  },
  "Action": "s3:GetObject",
  "Effect": "Allow",
  "Resource": "${bucket_arn}/*",
  "Condition": {
    "StringEquals": {
      "AWS:SourceArn": "${cloudfront_arn}"
    }
  }
}
