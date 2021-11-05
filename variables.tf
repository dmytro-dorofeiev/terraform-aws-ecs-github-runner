variable "environment" {
  description = "Environment name"
  type        = string
}

variable "github_org_name" {
  description = "Github repositroy org name, used on org level and could be skipped for repository level"
  type        = string
}

variable "github_owner_name" {
  description = "Github repositroy owner name, used on repository level and could be skipped for org level"
  type        = string
}

variable "github_repository_name" {
  description = "Github repository name, used on repository level and could be skipped for org level"
  type        = string
}
