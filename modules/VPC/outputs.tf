output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}
