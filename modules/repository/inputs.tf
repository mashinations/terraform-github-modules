variable "name" {
  description = "The name of the GitHub repository"
  type        = string
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
