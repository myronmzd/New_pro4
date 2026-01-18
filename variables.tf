variable "domain_name" {
  description = "The domain name for the website and API"
  type        = string
  default     = "myronmzd.com"
}

variable "review_path" {
  description = "The path for the review API"
  type        = string
  default     = "review"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "lambda_runtime" {
  description = "Runtime for Lambda functions"
  type        = string
  default     = "python3.9"
}