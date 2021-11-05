data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = [local.vpc_name]
  }
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "*private*"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = "*public*"
  }
}

data "aws_security_groups" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ecs_cluster" "default" {
  cluster_name = local.ecs_cluster_name
}

data "aws_kms_alias" "default" {
  name = "alias/${local.kms_key_alias}"
}

data "aws_kms_key" "default" {
  key_id = data.aws_kms_alias.default.arn
}

data "sops_file" "secret" {
  source_file = "secrets-${var.environment}.enc.yaml"
}
