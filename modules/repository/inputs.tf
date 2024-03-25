variable "name" {
  description = "The name of the GitHub repository"
  type        = string
}

## Repository Branches and Branch Protections
variable "branches" {
  default     = {}
  description = "A map of branches to create in the repository"
  type = map(object({
    is_default    = optional(bool, false)
    source_branch = optional(string, null)
    source_sha    = optional(string, null)
  }))

  validation {
    condition     = length({ for k, v in var.branches : k => v if v.is_default }) <= 1
    error_message = "Only one branch can be configured as the default"
  }
}

variable "branch_protections" {
  default     = {}
  description = "The branch protections to apply to the repository"
  type = map(object({
    allows_deletions                = optional(bool, false)
    allows_force_pushes             = optional(bool, false)
    enforce_admins                  = optional(bool, true)
    force_push_bypassers            = optional(set(string), [])
    lock_branch                     = optional(bool, false)
    require_conversation_resolution = optional(bool, true)
    require_signed_commits          = optional(bool, false)
    required_linear_history         = optional(bool, false)

    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews           = optional(bool, true)
      dismissal_restrictions          = optional(set(number), [])
      pull_request_bypassers          = optional(set(string), [])
      require_code_owner_reviews      = optional(bool, true)
      required_approving_review_count = optional(number, 1)
      require_last_push_approval      = optional(bool, true)
      restrict_dismissals             = optional(bool, true)
    }), {})
    required_status_checks = optional(object({
      contexts = optional(set(string), [])
      strict   = optional(bool, true)
    }), {})
    restrict_pushes = optional(object({
      blocks_creations = optional(bool, false)
      push_allowances  = optional(set(string), [])
    }), {})
  }))
}

## Repository Collaborators
variable "collaborators" {
  default     = {}
  description = "The teams and users to add as collaborators to the repository"
  type = object({
    teams = optional(object({
      admin    = optional(set(string), [])
      maintain = optional(set(string), [])
      pull     = optional(set(string), [])
      push     = optional(set(string), [])
      triage   = optional(set(string), [])
    }), {})
    users = optional(object({
      admin    = optional(set(string), [])
      maintain = optional(set(string), [])
      pull     = optional(set(string), [])
      push     = optional(set(string), [])
      triage   = optional(set(string), [])
    }), {})
  })
}

## Repository Features, Policies, and Settings
variable "actions" {
  default     = {}
  description = "An object containing configuration settings for GitHub Actions"
  type = object({
    allowed_actions = optional(string, "all")
    allowed_actions_config = optional(object({
      github_owned_allowed = optional(bool, true)
      patterns_allowed     = optional(set(string), null)
      verified_allowed     = optional(bool, true)
    }), {})
    secrets = optional(map(object({
      value      = string
      value_type = optional(string, "encrypted")
    })), {})
    variables = optional(map(object({
      value = string
    })), {})
  })
}

variable "dependabot" {
  default     = {}
  description = "An object containing configuration settings for GitHub Dependabot"
  type = object({
    secrets = optional(map(object({
      value      = string
      value_type = optional(string, "encrypted")
    })), {})
  })
}

variable "environments" {
  default     = {}
  description = "The environments to create and manage for the repository"
  type = map(object({
    deployment_branch_policy = optional(object({
      custom_branch_policies = optional(bool, false)
      protected_branches     = optional(bool, true)
    }), {})
    reviewers = optional(object({
      teams = optional(set(number), [])
      users = optional(set(number), [])
    }), {})
    secrets = optional(map(object({
      value      = string
      value_type = optional(string, "encrypted")
    })), {})
    variables = optional(map(object({
      value = string
    })), {})
    can_admins_bypass   = optional(bool, false)
    prevent_self_review = optional(bool, true)
    wait_timer          = optional(number, null)
  }))
}

variable "settings" {
  default     = {}
  description = "The settings to apply to the repository"
  type = object({
    archived           = optional(bool, false)
    auto_init          = optional(bool, true)
    description        = optional(string, null)
    gitignore_template = optional(string, null)
    homepage_url       = optional(string, null)
    is_template        = optional(bool, false)
    license_template   = optional(string, null)
    topics             = optional(set(string), [])
    visibility         = optional(string, "private")

    template = optional(object({
      owner      = string
      repository = string
    }))

    ## Feature Configuration
    has_discussions = optional(bool, false)
    has_issues      = optional(bool, true)
    has_projects    = optional(bool, false)
    has_wiki        = optional(bool, false)

    pages = optional(object({
      source = object({
        branch = optional(string, "main")
        path   = optional(string, "/")
      })
      cname = optional(string, null)
    }))

    ## Policy Configuration
    allow_auto_merge            = optional(bool, false)
    allow_merge_commit          = optional(bool, true)
    allow_rebase_merge          = optional(bool, true)
    allow_squash_merge          = optional(bool, true)
    allow_update_branch         = optional(bool, true)
    archive_on_destroy          = optional(bool, true)
    delete_branch_on_merge      = optional(bool, true)
    merge_commit_message        = optional(string, "BLANK")
    merge_commit_title          = optional(string, "PR_TITLE")
    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")
    squash_merge_commit_title   = optional(string, "PR_TITLE")
    vulnerability_alerts        = optional(bool, true)
    web_commit_signoff_required = optional(bool, false)

    security_and_analysis = optional(object({
      advanced_security = optional(object({
        status = optional(string, "disabled")
      }), {})
      secret_scanning = optional(object({
        status = optional(string, "disabled")
      }), {})
      secret_scanning_push_protection = optional(object({
        status = optional(string, "disabled")
      }), {})
    }), {})
  })
}
