resource "tfe_workspace" "tfe" {
  name         = "TFE"
  organization = var.tfe_organization_name
  vcs_repo {
    identifier     = "${var.github_user}/AWS-and-Terraform"
    oauth_token_id = tfe_oauth_client.github_oauth.oauth_token_id
    branch         = var.github_branch
  }
  execution_mode      = "remote"
  global_remote_state = true
  working_directory   = "/Homework4/TFE"
}

resource "tfe_variable" "tfe_organization_name" {
  key          = "tfe_organization_name"
  value        = var.tfe_organization_name
  description  = "Organization Name"
  category     = "terraform"
  workspace_id = tfe_workspace.tfe.id
}

resource "tfe_oauth_client" "github_oauth" {
  organization     = var.tfe_organization_name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_pat
  service_provider = "github"
}

resource "tfe_variable" "github_pat" {
  key          = "github_pat"
  value        = var.github_pat
  description  = "Github Personal Acess Token"
  category     = "terraform"
  workspace_id = tfe_workspace.tfe.id
  sensitive    = true
}

resource "tfe_variable" "github_user" {
  key          = "github_user"
  value        = var.github_user
  description  = "Github Username"
  category     = "terraform"
  workspace_id = tfe_workspace.tfe.id
}

resource "tfe_variable" "tfe_token" {
  key          = "TFE_TOKEN"
  value        = ""
  description  = "Terraform Cloud API Token"
  category     = "env"
  workspace_id = tfe_workspace.tfe.id
  sensitive    = true
}

resource "tfe_variable" "github_branch" {
  key          = "github_branch"
  value        = var.github_branch
  description  = "Github Branch Name (Default is main)"
  category     = "terraform"
  workspace_id = tfe_workspace.tfe.id
}

resource "tfe_variable" "oauth_token_id" {
  key          = "oauth_token_id"
  value        = tfe_oauth_client.github_oauth.id
  description  = "Generated OAuth ID"
  category     = "terraform"
  workspace_id = tfe_workspace.tfe.id
  sensitive    = true
}
