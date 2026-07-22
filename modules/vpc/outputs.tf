output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "igw_id" {
  description = "Internet Gateway ID"
  value       = one(aws_internet_gateway.this[*].id)
}

output "s3_endpoint_id" {
  description = "S3 VPC Endpoint ID"
  value       = one(aws_vpc_endpoint.s3[*].id)
}