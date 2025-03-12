variable "aws_region" {
  description = "La région AWS où sera déployée la table DynamoDB"
  type        = string
  default     = "eu-west-3"
}

variable "table_name" {
  description = "Nom de la table DynamoDB"
  type        = string
  default     = "MoussaTab"
}

variable "billing_mode" {
  description = "Mode de facturation de DynamoDB (PROVISIONED ou PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Nom de la clé primaire (partition key)"
  type        = string
  default     = "id"
}

variable "hash_key_type" {
  description = "Type de la clé primaire (S = String, N = Number, B = Binary)"
  type        = string
  default     = "S"
}
