output "subnet_ids" {
  description = "サブネットIDのマップ"
  value       = { for k, v in aws_subnet.this : k => v.id }
}

output "subnet_id_list" {
  description = "作成されたサブネットIDのリスト"
  value       = [for v in aws_subnet.this : v.id]
}

output "route_table_id" {
  description = "ルートテーブルのID"
  value       = aws_route_table.this.id
}