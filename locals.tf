locals {
  common_tags = {
    Environment = var.environment
    Managed_by  = "Terraform"
  }

  vpc_id              = data.aws_vpc.default.id
  vpc_public_subnets  = tolist(data.aws_subnet_ids.public.ids)
  vpc_private_subnets = tolist(data.aws_subnet_ids.private.ids)
  vpc_cidr_block      = data.aws_vpc.default.cidr_block
  vpc_name            = "${var.environment}-vpc"
  ecs_cluster_name    = "${var.environment}-ecs-cluster"
  kms_key_alias       = var.environment

  task_container_secrets = [
    {
      "prefix" = "/${var.environment}/github-runner"
      "parameters" = [
        {
          "name"  = "PAT"
          "value" = data.sops_file.secret.data["github.pat"]
        },
        {
          "name"  = "ORG"
          "value" = var.github_org_name
        },
        {
          "name"  = "GITHUB_OWNER"
          "value" = var.github_owner_name
        },
        {
          "name"  = "GITHUB_REPOSITORY"
          "value" = var.github_repository_name
        }
      ]
    }
  ]
}
