resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

output "id" {
  value = aws_default_vpc.default.id
}
