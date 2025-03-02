variable "amplify_app_name" {
  description = "Nom de l'application Amplify"
  type        = string
  default     = "website-plomberie"
}

variable "git_repository_url" {
  description = "URL du référentiel Git"
  type        = string
  default     = "https://api.github.com/repos/Mahmoud974/website-plomberie"
}

variable "git_branch" {
  description = "Branche Git à utiliser pour le déploiement"
  type        = string
  default     = "main"
}

variable "custom_domain" {
  description = "Domaine personnalisé pour l'application Amplify"
  type        = string
  default     = "www.plomberie-prestation-valence.com"
}
