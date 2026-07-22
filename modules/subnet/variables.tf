variable "prefix" {
  description = "プレフィックス"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

# キーは識別子、値はCIDRとAZ
variable "subnets" {
  description = "サブネット設定のマップ配列"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "is_public" {
  description = "サブネットがパブリックかどうか"
  type        = bool
  default     = false
}

variable "igw_id" {
  description = "インターネットゲートウェイのID（is_publicがtrueの場合に必須）"
  type        = string
  default     = null
}

variable "s3_endpoint_id" {
  description = "S3 VPCエンドポイントのID（S3エンドポイントを使用する場合に必須）"
  type        = string
  default     = null
}