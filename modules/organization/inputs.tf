variable "billing_email" {
  description = "The billing email for the organization"
  type        = string
}

## Organization Membership
variable "admins" {
  default     = []
  description = "The users to add to the organization with the 'admin' role."
  type        = set(string)
}
variable "admins_team" {
  default     = null
  description = "The team to create and add all admins to."
  type = object({
    name        = string
    description = optional(string, "Managed by Terraform")
    visibility  = optional(string, "closed")
  })
}

variable "members" {
  default     = []
  description = "The users to add to the organization with the 'member' role."
  type        = set(string)
}
variable "members_team" {
  default     = null
  description = "The team to create and add all members to."
  type = object({
    name        = string
    description = optional(string, "Managed by Terraform")
    visibility  = optional(string, "closed")
  })
}

variable "security_managers" {
  default     = []
  description = "The users to add to the organization as security managers."
  type        = set(string)
}
variable "security_managers_team" {
  default     = null
  description = "The team to create and add all security managers to."
  type = object({
    name        = string
    description = optional(string, "Managed by Terraform")
    visibility  = optional(string, "closed")
  })
}

## Organization Moderation
variable "blocked_users" {
  default     = []
  description = "The users to block from the organization"
  type        = set(string)
}

## Organization Features, Policies, and Settings
variable "actions" {
  default     = {}
  description = "An object containing configuration settings for GitHub Actions"
  type = object({
    secrets = optional(map(object({
      value          = string
      value_type     = optional(string, "encrypted")
      repository_ids = optional(set(string), null)
      visibility     = optional(string, "private")
    })), {})
    variables = optional(map(object({
      value          = string
      repository_ids = optional(set(string), null)
      visibility     = optional(string, "private")
    })), {})
  })

  validation {
    condition = alltrue([
      for k, v in var.actions.secrets : (
        v.visibility != "selected" ||
        v.visibility == "selected" && v.repository_ids != null
      )
    ])
    error_message = "The 'repository_ids' argument must be set when 'visibility' is set to 'selected'."
  }
}

variable "dependabot" {
  default     = {}
  description = "An object containing configuration settings for GitHub Dependabot"
  type = object({
    secrets = optional(map(object({
      value          = string
      value_type     = optional(string, "encrypted")
      repository_ids = optional(set(string), null)
      visibility     = optional(string, "private")
    })), {})
  })

  validation {
    condition = alltrue([
      for k, v in var.dependabot.secrets : (
        v.visibility != "selected" ||
        v.visibility == "selected" && v.repository_ids != null
      )
    ])
    error_message = "The 'repository_ids' argument must be set when 'visibility' is set to 'selected'."
  }
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
    dependabot_security_updates_enabled     = optional(bool, true)
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
    secret_scanning_push_protection_enabled  = optional(bool, false)
  })
}
