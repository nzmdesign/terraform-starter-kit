variable "prefix" {
  description = "プレフィックス"
  type        = string
}

variable "cidr_block" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_internet_gateway" {
  description = "インターネットゲートウェイを有効化するかどうか"
  type        = bool
  default     = false
}

variable "enable_s3_endpoint" {
  description = "S3エンドポイントを有効化するかどうか"
  type        = bool
  default     = true
}