variable "aws_region" {
  description = "La région AWS où déployer le VPC"
  type        = string
  default     = "eu-west-3"
}

variable "vpc_cidr" {
  description = "Plage d'adresses IP du VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_1_cidr" {
  description = "Plage d'adresses IP du sous-réseau privé 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_2_cidr" {
  description = "Plage d'adresses IP du sous-réseau privé 2"
  type        = string
  default     = "10.0.2.0/24"
}
