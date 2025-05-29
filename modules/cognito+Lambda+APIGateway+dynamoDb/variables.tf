variable "region" {
  default = "eu-west-3"
}

variable "user_pool_name" {
  default = "pool-valence-royal"
}

variable "client_name" {
  default = "function-valence-royal"
}

variable "callback_urls" {
  type    = list(string)
  default = ["https://localhost:3000/callback"]
}

variable "logout_urls" {
  type    = list(string)
  default = ["https://localhost:3000/logout"]
}

variable "dynamodb_table_name" {
  default = "table-valence-royal"
}
