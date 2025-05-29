variable "lambda_function_name" {
  description = "Nom de la fonction Lambda"
  type        = string
  default     = "royal-food-prod"
}

variable "api_gateway_name" {
  description = "Nom de l'API Gateway"
  type        = string
  default     = "royal-food-prod-api"
}

variable "region" {
  description = "La région AWS"
  type        = string
  default     = "eu-west-3"
}

variable "lambda_execution_role_name" {
  description = "Nom du rôle IAM pour Lambda"
  type        = string
  default     = "lambda_execution_role-royal"
}
