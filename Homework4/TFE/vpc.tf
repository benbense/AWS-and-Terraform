resource "tfe_workspace" "vpc" {
  name         = "VPC"
  organization = var.tfe_organization_name
  vcs_repo {
    identifier     = "${var.github_user}/AWS-and-Terraform"
    oauth_token_id = var.github_oauth
    branch         = var.github_branch
  }
  auto_apply          = var.auto_apply
  global_remote_state = true
  execution_mode      = "remote"
  working_directory   = "/Homework4/VPC"
}
