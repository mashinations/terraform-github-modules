terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 5.20, < 7.0"
    }
  }
  required_version = "~> 1.3"
}
