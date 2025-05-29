variable "lambda_function_name" {
  description = "Nom de la fonction Lambda"
  type        = string
  default     = "prod-tacos-function"
}

variable "dynamodb_table_name" {
  description = "Nom de la table DynamoDB"
  type        = string
  default     = "prod-tacos-table"
}

variable "region" {
  description = "Région AWS"
  type        = string
  default     = "eu-west-3"
}
