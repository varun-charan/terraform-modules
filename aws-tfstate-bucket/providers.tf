provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/barco-assume-automation"
  }
}

terraform {
  required_version = ">= 1.0.11"
  # The configuration for this backend will be filled in by Terragrunt
  # backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.46"
    }
  }
}



