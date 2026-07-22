resource "aws_security_group" "this" {
  name        = "${var.prefix}-sg-${var.service}"
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.prefix}-sg-${var.service}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = { for idx, rule in var.ingress_rules : idx => rule }

  security_group_id            = aws_security_group.this.id
  from_port                    = each.value.from_port
  to_port                      = each.value.to_port
  ip_protocol                  = each.value.ip_protocol
  cidr_ipv4                    = lookup(each.value, "cidr_ipv4", null)
  referenced_security_group_id = lookup(each.value, "referenced_security_group_id", null)
  description                  = lookup(each.value, "description", null)
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = { for idx, rule in var.egress_rules : idx => rule }

  security_group_id            = aws_security_group.this.id
  from_port                    = lookup(each.value, "from_port", null)
  to_port                      = lookup(each.value, "to_port", null)
  ip_protocol                  = each.value.ip_protocol
  cidr_ipv4                    = lookup(each.value, "cidr_ipv4", null)
  referenced_security_group_id = lookup(each.value, "referenced_security_group_id", null)
  description                  = lookup(each.value, "description", null)
}