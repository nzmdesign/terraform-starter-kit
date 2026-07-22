output "id" {
  description = "EC2インスタンスID"
  value       = aws_instance.this.id
}

output "private_ip" {
  description = "EC2インスタンスのプライベートIPアドレス"
  value       = aws_instance.this.private_ip
}