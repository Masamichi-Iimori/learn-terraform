locals {
  github_token        = data.aws_ssm_parameter.github_token.value
  github_organization = data.aws_ssm_parameter.github_organization.value
}

data "aws_ssm_parameter" "github_token" {
  name = "/terraform/deployment/github/token"
}

data "aws_ssm_parameter" "github_organization" {
  name = "/terraform/deployment/github/organization"
}
