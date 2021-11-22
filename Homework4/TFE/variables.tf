variable "tfe_organization_name" {
  description = "Terrafrom Cloud Organization Name"
  type        = string
}

variable "github_user" {
  description = "Github Username"
  type        = string
}

variable "oauth_token_id" {
  description = "Github OAuth Token"
  type        = string
}

variable "branch" {
  description = "Github Branch Name"
  type        = string
}

variable "auto_apply" {
  description = "Automatically apply changes on successful plan "
  type        = bool
  default     = false
}
