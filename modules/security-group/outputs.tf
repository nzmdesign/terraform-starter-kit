output "id" {
  description = "セキュリティグループID"
  value       = aws_security_group.this.id
}

output "name" {
  description = "セキュリティグループ名"
  value       = aws_security_group.this.name
}