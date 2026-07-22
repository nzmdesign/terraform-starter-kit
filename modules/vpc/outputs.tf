output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "igw_id" {
  description = "Internet Gateway ID"
  value       = one(aws_internet_gateway.this[*].id)
}