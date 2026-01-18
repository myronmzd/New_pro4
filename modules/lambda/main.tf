# Lambda Functions Module

resource "aws_iam_role" "lambda_role" {
  name = "review_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${var.temp_bucket_arn}/*",
          "${var.reports_bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "comprehend:DetectSentiment"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "data_collection" {
  function_name = "review_data_collection"
  runtime       = var.lambda_runtime
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn

  filename         = var.data_collection_zip
  source_code_hash = filebase64sha256(var.data_collection_zip)

  environment {
    variables = {
      TEMP_BUCKET = var.temp_bucket_name
    }
  }
}

resource "aws_lambda_function" "sentiment_report" {
  function_name = "review_sentiment_report"
  runtime       = var.lambda_runtime
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn

  filename         = var.sentiment_report_zip
  source_code_hash = filebase64sha256(var.sentiment_report_zip)

  environment {
    variables = {
      TEMP_BUCKET   = var.temp_bucket_name
      REPORT_BUCKET = var.reports_bucket_name
    }
  }
}

resource "aws_lambda_permission" "data_collection_api" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.data_collection.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = var.api_gateway_execution_arn
}

resource "aws_lambda_permission" "sentiment_report_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sentiment_report.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.temp_bucket_arn
}