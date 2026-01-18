terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "dns" {
  source = "./modules/dns"

  domain_name = var.domain_name
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
}

module "acm" {
  source = "./modules/acm"

  domain_name = var.domain_name
  zone_id = module.dns.zone_id
}

module "s3" {
  source = "./modules/s3"

  domain_name = var.domain_name
  sentiment_lambda_arn = module.lambda.sentiment_report_lambda_arn
}

module "lambda" {
  source = "./modules/lambda"

  lambda_runtime = var.lambda_runtime
  temp_bucket_name = module.s3.temp_bucket_name
  reports_bucket_name = module.s3.reports_bucket_name
  temp_bucket_arn = "arn:aws:s3:::${module.s3.temp_bucket_name}"
  reports_bucket_arn = "arn:aws:s3:::${module.s3.reports_bucket_name}"
  data_collection_zip = "lambda_data_collection.zip"  # Placeholder
  sentiment_report_zip = "lambda_sentiment_report.zip"  # Placeholder
  api_gateway_execution_arn = "${module.api_gateway.api_gateway_execution_arn}/*/*"
}

module "api_gateway" {
  source = "./modules/api_gateway"

  review_path = var.review_path
  data_collection_lambda_invoke_arn = module.lambda.data_collection_lambda_arn
}

module "cloudfront" {
  source = "./modules/cloudfront"

  website_bucket_name = module.s3.website_bucket_name
  website_bucket_domain = module.s3.website_bucket_domain
  api_gateway_id = module.api_gateway.api_gateway_id
  aws_region = var.aws_region
  domain_name = var.domain_name
  review_path = var.review_path
  acm_certificate_arn = module.acm.acm_certificate_arn
}

module "ses" {
  source = "./modules/ses"

  domain_name = var.domain_name
}