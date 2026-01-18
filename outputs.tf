output "cloudfront_domain" {
  value = module.cloudfront.cloudfront_domain_name
}

output "api_gateway_url" {
  value = module.api_gateway.api_gateway_invoke_url
}

output "website_bucket" {
  value = module.s3.website_bucket_name
}

output "temp_bucket" {
  value = module.s3.temp_bucket_name
}

output "reports_bucket" {
  value = module.s3.reports_bucket_name
}