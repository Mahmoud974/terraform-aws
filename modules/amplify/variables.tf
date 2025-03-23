variable "amplify_app_name" {
  description = "Nom de l'application Amplify"
  type        = string
  default     = "website-product-card"
}

variable "git_repository_url" {
  description = "URL du référentiel Git"
  type        = string
  default     = "https://github.com/Mahmoud974/Product_cart.git"
}

variable "git_branch" {
  description = "Branche Git à utiliser pour le déploiement"
  type        = string
  default     = "main"
}

variable "custom_domain" {
  description = "Domaine personnalisé pour l'application Amplify"
  type        = string
  default     = "www.product-card.com"
}
