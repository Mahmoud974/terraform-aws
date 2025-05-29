variable "region" {
  default = "eu-west-1"
}

variable "user_pool_name" {
  default = "user-pool"
}

variable "client_name" {
  default = "client-app"
}

variable "callback_urls" {
  type    = list(string)
  default = ["http://localhost:3000/callback"]
}

variable "logout_urls" {
  type    = list(string)
  default = ["http://localhost:3000/logout"]
}

variable "db_name" {
  default = "mydb"
}

variable "db_user" {
  default = "admin"
}

variable "db_password" {
  default = "VeryStrongPassword123!"
}
