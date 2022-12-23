variable "billing_email" {
  description = "The billing email for the organization"
  type        = string
}

variable "settings" {
  default     = {}
  description = "The settings to apply to the organization"
  type = object({
    blog             = optional(string)
    company          = optional(string)
    description      = optional(string)
    email            = optional(string)
    location         = optional(string)
    name             = optional(string)
    twitter_username = optional(string)

    ## GitHub Settings
    default_repository_permission           = optional(string, "read")
    dependabot_alerts_enabled               = optional(bool, true)
    dependency_graph_enabled                = optional(bool, true)
    has_organization_projects               = optional(bool, false)
    has_repository_projects                 = optional(bool, false)
    members_can_create_pages                = optional(bool, false)
    members_can_create_private_pages        = optional(bool, false)
    members_can_create_private_repositories = optional(bool, false)
    members_can_create_public_pages         = optional(bool, false)
    members_can_create_public_repositories  = optional(bool, false)
    members_can_create_repositories         = optional(bool, false)
    members_can_fork_private_repositories   = optional(bool, false)
    secret_scanning_enabled                 = optional(bool, true)
    web_commit_signoff_required             = optional(bool, false)

    ## GitHub Enterprise Settings
    advanced_security_enabled                = optional(bool, false)
    members_can_create_internal_repositories = optional(bool, false)
  })
}
