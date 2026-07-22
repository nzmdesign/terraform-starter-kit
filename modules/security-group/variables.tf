variable "prefix" {
  description = "プレフィックス"
  type        = string
}

variable "service" {
  description = "サービス名"
  type        = string
}

variable "description" {
  description = "セキュリティグループの説明"
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "セキュリティグループを作成するVPCのID"
  type        = string
}

variable "ingress_rules" {
  description = "インバウンドルールのリスト"
  type = list(object({
    from_port                    = number
    to_port                      = number
    ip_protocol                  = string
    cidr_ipv4                    = optional(string)
    referenced_security_group_id = optional(string)
    description                  = optional(string)
  }))
  default = []
}

# デフォルト設定はアウトバウンド全許可
# ip_protocolが"-1"の場合のためにfrom_portとto_portはオプション
variable "egress_rules" {
  description = "アウトバウンドルールのリスト"
  type = list(object({
    from_port                    = optional(number)
    to_port                      = optional(number)
    ip_protocol                  = string
    cidr_ipv4                    = optional(string)
    referenced_security_group_id = optional(string)
    description                  = optional(string)
  }))
  default = [
    {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]
}