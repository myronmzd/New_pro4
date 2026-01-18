# API Gateway Module

resource "aws_api_gateway_rest_api" "review_api" {
  name        = "review_api"
  description = "API for Review & Sentiment Pipeline"
}

resource "aws_api_gateway_resource" "review" {
  rest_api_id = aws_api_gateway_rest_api.review_api.id
  parent_id   = aws_api_gateway_rest_api.review_api.root_resource_id
  path_part   = var.review_path
}

resource "aws_api_gateway_method" "review_get" {
  rest_api_id   = aws_api_gateway_rest_api.review_api.id
  resource_id   = aws_api_gateway_resource.review.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "review_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.review_api.id
  resource_id             = aws_api_gateway_resource.review.id
  http_method             = aws_api_gateway_method.review_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.data_collection_lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "review" {
  depends_on = [aws_api_gateway_integration.review_lambda]

  rest_api_id = aws_api_gateway_rest_api.review_api.id
  stage_name  = "prod"
}