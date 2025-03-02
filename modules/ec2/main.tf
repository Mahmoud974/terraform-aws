provider "aws" {
  region = "eu-west-3"
}

# Création de l'instance EC2
resource "aws_instance" "example" {
  ami           = "ami-0446057e5961dfab6"
  instance_type = "t2.micro"

  # User Data pour créer un site web simple
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello, World!" > /var/www/html/index.html
              EOF

  # Ajouter des tags
  tags = {
    Name = "MyFreeTierInstance"
  }

  # Groupe de sécurité
  security_groups = ["default"]

  # Activer une IP publique pour l'accès à l'instance
  associate_public_ip_address = true

  # Ajout d'un volume EBS supplémentaire
  ebs_block_device {
    device_name           = "/dev/sdh"
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
  }
}
