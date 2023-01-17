terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.15"
    }
  }
  required_version = "~> 1.3"
}
