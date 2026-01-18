variable "domain_name" {
  description = "The domain name"
  type        = string
}

variable "sentiment_lambda_arn" {
  description = "ARN of the sentiment Lambda function"
  type        = string
}