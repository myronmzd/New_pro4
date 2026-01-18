output "api_gateway_id" {
  value = aws_api_gateway_rest_api.review_api.id
}

output "api_gateway_execution_arn" {
  value = aws_api_gateway_rest_api.review_api.execution_arn
}

output "api_gateway_invoke_url" {
  value = aws_api_gateway_deployment.review.invoke_url
}