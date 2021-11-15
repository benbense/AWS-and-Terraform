provider "aws" {
  region = var.region
}

terraform {
  backend "remote" {
    organization = "opsschool-ben"
    workspaces {
      name = "VPC"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63"
    }
  }
}
