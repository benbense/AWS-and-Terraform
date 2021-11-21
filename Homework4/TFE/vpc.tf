resource "tfe_workspace" "vpc" {
  name         = "VPC"
  organization = var.tfc_organization_name
  vcs_repo {
    identifier     = "${var.github_user}/AWS-and-Terraform"
    oauth_token_id = var.oauth_token
  }
  auto_apply          = var.auto_apply
  global_remote_state = true
  execution_mode      = "remote"
  working_directory   = "/Homework4/VPC"
}
