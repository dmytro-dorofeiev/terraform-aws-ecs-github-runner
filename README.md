# terraform-aws-ecs-github-runner

Terraform setup to create self-hosted github runner on AWS ECS Fargate as a service.
Docker folder contains two types of Dockerfile:

1. For github organization
2. For github repo

## Requirements

- installed Terraform v0.13 or later
- installed [sops](https://github.com/mozilla/sops)
- created vpc
- created kms key
- running ecs cluster

## Usage

1. Clone repository
2. Adjust terraform variables
3. Set PAT secret with sops

```hcl
sops -e -k arn:kms secrets-dev.yaml secrets-dev.enc.yaml
rm -f secrets-dev.yaml
terraform plan
terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_sops"></a> [sops](#requirement\_sops) | >= 0.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.76.1 |
| <a name="provider_sops"></a> [sops](#provider\_sops) | 0.7.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_autoscale"></a> [autoscale](#module\_autoscale) | git::https://github.com/dmytro-dorofeiev/terraform-aws-autoscale-module | n/a |
| <a name="module_github-runner"></a> [github-runner](#module\_github-runner) | git::https://github.com/dmytro-dorofeiev/terraform-aws-ecs-fargate-module | n/a |
| <a name="module_task_container_secrets"></a> [task\_container\_secrets](#module\_task\_container\_secrets) | git::https://github.com/dmytro-dorofeiev/terraform-aws-ssm-module | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy_attachment.PowerUserAccess_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group_rule.github_runner_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ecs_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_cluster) | data source |
| [aws_kms_alias.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |
| [aws_kms_key.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_security_groups.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_groups) | data source |
| [aws_subnet_ids.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [sops_file.secret](https://registry.terraform.io/providers/carlpett/sops/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_github_org_name"></a> [github\_org\_name](#input\_github\_org\_name) | Github repositroy org name, used on org level and could be skipped for repository level | `string` | n/a | yes |
| <a name="input_github_owner_name"></a> [github\_owner\_name](#input\_github\_owner\_name) | Github repositroy owner name, used on repository level and could be skipped for org level | `string` | n/a | yes |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | Github repository name, used on repository level and could be skipped for org level | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
