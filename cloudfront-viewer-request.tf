resource "aws_cloudfront_function" "viewer_request" {
  count = length(local.site_redirects) > 0 ? 1 : 0

  name    = "${local.project_name}-viewer-request"
  runtime = "cloudfront-js-1.0"
  comment = "${local.project_name} viewer-request function"
  publish = true
  code = templatefile(
    "${path.module}/cloudfront-functions/viewer-request.js",
    {
      redirects = jsonencode(local.site_redirects)
    }
  )
}
