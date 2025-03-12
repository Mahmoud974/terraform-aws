output "table_name" {
  description = "Nom de la table DynamoDB"
  value       = aws_dynamodb_table.example.name
}

output "table_arn" {
  description = "ARN de la table DynamoDB"
  value       = aws_dynamodb_table.example.arn
}

output "table_id" {
  description = "ID de la table DynamoDB"
  value       = aws_dynamodb_table.example.id
}
