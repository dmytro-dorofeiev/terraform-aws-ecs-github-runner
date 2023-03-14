terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = ">= 0.7"
    }
  }
  # backend "s3" {
  # encrypt        = true
  # bucket         = "state-bucket"
  # key            = "apps/github-runner.tfstate"
  # region         = "eu-west-1"
  # dynamodb_table = "terraform_state_lock"
  # }
}

provider "aws" {
  region = "eu-west-1"
}
