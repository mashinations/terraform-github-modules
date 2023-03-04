variable "name" {
  description = "The name of the GitHub repository"
  type        = string
}

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
    blocks_creations                = optional(bool, false)
    enforce_admins                  = optional(bool, true)
    lock_branch                     = optional(bool, false)
    push_restrictions               = optional(set(string), [])
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
  })
}
