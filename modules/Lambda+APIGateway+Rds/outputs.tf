output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}

output "api_url" {
  value = aws_api_gateway_rest_api.api.execution_arn
}

output "rds_endpoint" {
  value = aws_db_instance.db.endpoint
}
