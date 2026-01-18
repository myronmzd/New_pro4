variable "website_bucket_name" {
  description = "Name of website S3 bucket"
  type        = string
}

variable "website_bucket_domain" {
  description = "Domain of website S3 bucket"
  type        = string
}

variable "api_gateway_id" {
  description = "ID of API Gateway"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "review_path" {
  description = "Review path"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of ACM certificate"
  type        = string
}