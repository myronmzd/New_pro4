output "website_bucket_name" {
  value = aws_s3_bucket.website.bucket
}

output "temp_bucket_name" {
  value = aws_s3_bucket.temp.bucket
}

output "reports_bucket_name" {
  value = aws_s3_bucket.reports.bucket
}

output "website_bucket_domain" {
  value = aws_s3_bucket.website.bucket_regional_domain_name
}