provider "aws" {
  region = "eu-west-3" # Choisir la région AWS pour ton application Amplify
}

# Créer l'application Amplify
resource "aws_amplify_app" "amplify_app" {
  name        = var.amplify_app_name
  repository  = var.git_repository_url
  oauth_token = "YOUR_GITHUB_OAUTH_TOKEN"

  environment_variables = {
    NODE_ENV = "production"
  }
}

# Créer la branche dans l'application Amplify
resource "aws_amplify_branch" "amplify_branch" {
  app_id      = aws_amplify_app.amplify_app.id
  branch_name = var.git_branch # Utiliser la branche spécifiée

  # Optionnel : spécifier des variables d'environnement pour la branche
  environment_variables = {
    NODE_ENV = "production"
  }
}

# Ajouter un domaine personnalisé
resource "aws_amplify_domain_association" "amplify_domain" {
  app_id      = aws_amplify_app.amplify_app.id
  domain_name = var.custom_domain

  # Pour associer un sous-domaine, tu spécifies le nom de la branche dans "sub_domain"
  sub_domain {
    branch_name = aws_amplify_branch.amplify_branch.branch_name
    prefix      = "www" # Le préfixe "www" ou tout autre préfixe que tu souhaites
  }
}
