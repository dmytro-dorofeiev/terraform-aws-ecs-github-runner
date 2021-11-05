module "github-runner" {
  source = "git::https://github.com/dmytro-dorofeiev/terraform-aws-ecs-fargate-module"

  name_prefix             = "github-runner"
  service_name            = "github-runner"
  vpc_id                  = local.vpc_id
  private_subnet_ids      = local.vpc_private_subnets
  cluster_id              = data.aws_ecs_cluster.default.arn
  desired_count           = 1
  lb_arn                  = "none"
  task_container_protocol = "TCP"
  task_container_image    = "*****.dkr.ecr.eu-west-1.amazonaws.com/tools:ecs-runner"
  task_definition_cpu     = 512
  task_definition_memory  = 1024
  task_container_port     = 80
  task_container_secrets  = module.task_container_secrets.dynamic_secrets_json
  load_balanced           = false

  ssm_allowed_parameters = "*"
  kms_key_arn            = data.aws_kms_key.default.arn

  health_check = {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
  }

  tags = local.common_tags

}

resource "aws_security_group_rule" "github_runner_rule" {
  description       = "Security Group who can access github-runner"
  security_group_id = module.github-runner.service_sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_iam_role_policy_attachment" "PowerUserAccess_attach" {
  role       = module.github-runner.task_role_name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

# ## Autoscale services based on meterics
module "autoscale" {
  source = "git::https://github.com/dmytro-dorofeiev/terraform-aws-autoscale-module"

  service_name = "github-runner"
  cluster_name = local.ecs_cluster_name
  max_replicas = 5
  min_replicas = 1
  max_cpu_util = 60
  scale_in_cpu_cooldown = 60
  scale_out_cpu_cooldown = 60
}

## task definition secrets
module "task_container_secrets" {
  source         = "git::https://github.com/dmytro-dorofeiev/terraform-aws-ssm-module"
  parameters     = local.task_container_secrets
  kms_key_id     = data.aws_kms_alias.default.arn
  ignore_changes = false
  overwrite      = true
  tags           = local.common_tags
}
