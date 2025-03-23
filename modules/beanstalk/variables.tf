variable "region" {
  description = "Région AWS où déployer l'application"
  type        = string
  default     = "eu-west-2"
}

variable "app_name" {
  description = "Nom de l'application Elastic Beanstalk"
  type        = string
  default     = "mon-application-moussa"
}

variable "env_name" {
  description = "Nom de l'environnement Elastic Beanstalk"
  type        = string
  default     = "mon-environnement"
}

variable "instance_type" {
  description = "Type d'instance EC2 à utiliser"
  type        = string
  default     = "t2.micro"
}

variable "solution_stack_name" {
  description = "Plateforme Elastic Beanstalk à utiliser"
  type        = string
  default     = "64bit Amazon Linux 2 v5.9.12 running Node.js 18"
}
