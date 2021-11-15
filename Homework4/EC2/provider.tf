provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "remote" {
    organization = "opsschool-ben"
    workspaces {
      name = "EC2"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.65"
    }
  }
}
