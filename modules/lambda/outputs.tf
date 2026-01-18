output "data_collection_lambda_arn" {
  value = aws_lambda_function.data_collection.arn
}

output "sentiment_report_lambda_arn" {
  value = aws_lambda_function.sentiment_report.arn
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_role.arn
}