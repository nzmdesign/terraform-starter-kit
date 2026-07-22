locals {
  project     = var.project
  account_id  = var.aws_account_id
  env         = var.environment
  bucket_name = "${local.project}-${local.account_id}-${local.env}-tfstate"
}

# tfstate用S3バケット本体
resource "aws_s3_bucket" "tfstate" {
  bucket = local.bucket_name

  # 誤削除防止（削除時はコメントアウト）
  lifecycle {
    prevent_destroy = true
  }
}

# バージョニングの有効化
resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 暗号化の設定
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# パブリックアクセスの完全ブロック
resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}