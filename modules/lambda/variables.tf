variable "lambda_runtime" {
  description = "Runtime for Lambda"
  type        = string
}

variable "temp_bucket_name" {
  description = "Name of temp S3 bucket"
  type        = string
}

variable "reports_bucket_name" {
  description = "Name of reports S3 bucket"
  type        = string
}

variable "temp_bucket_arn" {
  description = "ARN of temp S3 bucket"
  type        = string
}

variable "reports_bucket_arn" {
  description = "ARN of reports S3 bucket"
  type        = string
}

variable "data_collection_zip" {
  description = "Path to data collection Lambda zip"
  type        = string
}

variable "sentiment_report_zip" {
  description = "Path to sentiment report Lambda zip"
  type        = string
}

variable "api_gateway_execution_arn" {
  description = "Execution ARN of API Gateway"
  type        = string
}