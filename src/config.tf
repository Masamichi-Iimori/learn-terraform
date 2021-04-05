terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "ap-northeast-1"
}

provider "github" {
  token = local.github_token
  owner = local.github_organization
}
