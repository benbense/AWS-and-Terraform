provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

terraform {
  backend "remote" {
    organization = "opsschool-ben"
    workspaces {
      name = "AWS-and-Terraform"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63"
    }
  }
}
