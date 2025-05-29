variable "region" {
  description = "Région AWS"
  default     = "eu-west-3"
}

variable "user_pool_name" {
  description = "Nom du User Pool Cognito"
  default     = "mon-user-pool"
}

variable "client_name" {
  description = "Nom du client d'application"
  default     = "mon-client-app"
}

variable "callback_urls" {
  description = "Liste des URLs de callback"
  type        = list(string)
  default     = ["https://localhost:3000/callback"]
}

variable "logout_urls" {
  description = "Liste des URLs de logout"
  type        = list(string)
  default     = ["https://localhost:3000/logout"]
}
