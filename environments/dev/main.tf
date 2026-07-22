locals {
  prefix = "${var.project}-${var.environment}"
}

module "vpc" {
  source = "../../modules/vpc"

  prefix                  = local.prefix
  cidr_block              = "10.0.0.0/16"
  enable_internet_gateway = true
}

module "public_subnet" {
  source = "../../modules/subnet"

  prefix    = local.prefix
  vpc_id    = module.vpc.vpc_id
  is_public = true
  igw_id    = module.vpc.igw_id

  s3_endpoint_id = module.vpc.s3_endpoint_id

  subnets = {
    public1 = {
      cidr = "10.0.0.0/24"
      az   = "ap-northeast-1a"
    }
  }
}

module "private_subnet" {
  source = "../../modules/subnet"

  prefix    = local.prefix
  vpc_id    = module.vpc.vpc_id
  is_public = false

  s3_endpoint_id = module.vpc.s3_endpoint_id

  subnets = {
    private1 = {
      cidr = "10.0.128.0/24"
      az   = "ap-northeast-1a"
    }
  }
}

module "web_sg" {
  source = "../../modules/security_group"

  prefix  = local.prefix
  service = "web"
  vpc_id  = module.vpc.vpc_id
}

resource "aws_iam_role" "web" {
  name = "${local.prefix}-role-web"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "web_custom" {
  name        = "${local.prefix}-policy-web-custom"
  description = "Custom policy for web server"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "web_ssm" {
  role       = aws_iam_role.web.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "web_custom" {
  role       = aws_iam_role.web.name
  policy_arn = aws_iam_policy.web_custom.arn
}

resource "aws_iam_instance_profile" "web" {
  name = "${local.prefix}-profile-web"
  role = aws_iam_role.web.name
}

module "web_server" {
  source = "../../modules/ec2"

  prefix                 = local.prefix
  service                = "web"
  ami_id                 = "ami-0aae00de4a3cf9639"
  subnet_id              = module.public_subnet.subnet_id_list[0]
  vpc_security_group_ids = [module.web_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.web.name
}