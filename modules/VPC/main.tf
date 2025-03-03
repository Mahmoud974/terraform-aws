# Création du VPC
resource "aws_vpc" "mon_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "MonVPC"
  }
}

# Internet Gateway pour le VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mon_vpc.id

  tags = {
    Name = "InternetGateway"
  }
}

# Sous-réseau public
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.mon_vpc.id
  cidr_block              = "10.0.3.0/24" # Nouveau sous-réseau public
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true # Important pour le NAT Gateway

  tags = {
    Name = "PublicSubnet"
  }
}

# Sous-réseau privé 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.mon_vpc.id
  cidr_block              = var.private_subnet_1_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = false # Pas de IP publique

  tags = {
    Name = "PrivateSubnet1"
  }
}

# Sous-réseau privé 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.mon_vpc.id
  cidr_block              = var.private_subnet_2_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = false # Pas de IP publique

  tags = {
    Name = "PrivateSubnet2"
  }
}

# Table de routage publique
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mon_vpc.id

  tags = {
    Name = "PublicRouteTable"
  }
}

# Route vers Internet via l'IGW
resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Association de la table de routage publique au sous-réseau public
resource "aws_route_table_association" "public_subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Elastic IP pour le NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT Gateway dans le sous-réseau public
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id # NAT doit être dans un sous-réseau public

  tags = {
    Name = "NATGateway"
  }
}
