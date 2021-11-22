terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.26.1"
    }
  }

  backend "remote" {
    organization = "opsschool-ben"
    workspaces {
      name = "TFE"
    }
  }
}

provider "tfe" {
}
