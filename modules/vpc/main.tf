resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  count = var.enable_internet_gateway ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}