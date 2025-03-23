output "application_name" {
  description = "Nom de l'application Elastic Beanstalk"
  value       = aws_elastic_beanstalk_application.app.name
}

output "environment_url" {
  description = "URL de l'environnement Elastic Beanstalk"
  value       = aws_elastic_beanstalk_environment.env.endpoint_url
}
