locals {
  subnet_type = var.is_public ? "public" : "private"
}

# 1. サブネット群
resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = var.is_public

  tags = {
    Name = "${var.prefix}-${local.subnet_type}-subnet-${each.key}"
  }
}

# 2. ルートテーブル
resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.prefix}-${local.subnet_type}-rt"
  }
}

# 3. Public指定の場合のみIGWへのルートを追加
resource "aws_route" "public_internet_gateway" {
  count = var.is_public && var.igw_id != null ? 1 : 0

  route_table_id         = aws_route_table.this.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

# 4. サブネットとルートテーブルの関連付け
resource "aws_route_table_association" "this" {
  for_each = aws_subnet.this

  subnet_id      = each.value.id
  route_table_id = aws_route_table.this.id
}