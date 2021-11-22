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


data "tfe_oauth_client" "github_oauth" {
  oauth_client_id = var.oauth_token_id
}
