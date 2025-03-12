output "lambda_function_name" {
  description = "Nom de la fonction Lambda"
  value       = aws_lambda_function.my_lambda.function_name
}

output "api_url" {
  description = "URL de l'API Gateway"
  value       = "https://${aws_api_gateway_rest_api.my_api.id}.execute-api.${var.region}.amazonaws.com/prod/hello"
}
