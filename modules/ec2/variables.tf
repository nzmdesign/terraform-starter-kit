variable "prefix" {
  description = "プレフィックス"
  type        = string
}

variable "service" {
  description = "サービス名"
  type        = string
}

variable "ami_id" {
  description = "EC2インスタンスで使用するAMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2インスタンスのタイプ"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "EC2インスタンスを起動するVPCサブネットID"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "関連付けるセキュリティグループIDのリスト"
  type        = list(string)
  default     = []
}

variable "iam_instance_profile" {
  description = "EC2インスタンスに関連付けるIAMインスタンスプロファイルの名前"
  type        = string
  default     = null
}