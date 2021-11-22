resource "tfe_workspace" "ec2" {
  name         = "EC2"
  organization = var.tfe_organization_name
  vcs_repo {
    identifier     = "${var.github_user}/AWS-and-Terraform"
    oauth_token_id = var.oauth_token_id
    branch         = var.github_branch
  }
  auto_apply          = var.auto_apply
  global_remote_state = true
  execution_mode      = "remote"
  working_directory   = "/Homework4/EC2"
}

resource "tfe_run_trigger" "vpc_creation" {
  workspace_id  = tfe_workspace.ec2.id
  sourceable_id = tfe_workspace.vpc.id
}
