> **WARNING**
> This module is in development and should not be considered stable until v1.0.0 is released or is otherwise indicated by the removal of this message from the documentation.

A Terraform module to create and manage a GitHub repository and various repository-related features.


# Features

In addition to creating the specified repository, the following features are supported:

- **Branch Management** - Create branches and optionally designate one as the default branch
- **Branch Protections** - Create branch protections for branches matching the specified pattern(s)
- **Collaborators** - Grant teams or users access to the repository with the specified permissions
- **Settings** - Manage the repository's policies and settings

# Getting Started

Basic usage of this module is as follows:

```hcl
module "example" {
  source = "github.com/mashinations/terraform-github//modules/repository?ref=main"

  name = "example-repository"

  branches = {
    default = { is_default }
    staging = {}
  }

  branch_protections = {
    main = {
      allows_deletions                = false
      allows_force_pushes             = false
      blocks_creations                = false
      enforce_admins                  = true
      lock_branch                     = false
      push_restrictions               = []
      require_conversation_resolution = true
      require_signed_commits          = false
      required_linear_history         = false

      required_pull_request_reviews = {
        dismiss_stale_reviews           = true
        dismissal_restrictions          = []
        pull_request_bypassers          = []
        require_code_owner_reviews      = true
        required_approving_review_count = 1
        require_last_push_approval      = true
        restrict_dismissals             = true
      }
      required_status_checks = {
        contexts = []
        strict   = true
      }
    }
  }

  settings = {
    description  = "An example repository"
    homepage_url = "https://example.com"

    archived           = false
    auto_init          = true
    gitignore_template = "Terraform"
    is_template        = false
    license_template   = "apache-2.0"
    topics             = []
    visibility         = "private"

    has_discussions = false
    has_issues      = true
    has_projects    = false
    has_wiki        = false

    allow_auto_merge            = false
    allow_merge_commit          = true
    allow_rebase_merge          = true
    allow_squash_merge          = true
    allow_update_branch         = true
    archive_on_destroy          = true
    delete_branch_on_merge      = true
    merge_commit_message        = "BLANK"
    merge_commit_title          = "PR_TITLE"
    squash_merge_commit_message = "COMMIT_MESSAGES"
    squash_merge_commit_title   = "PR_TITLE"
    vulnerability_alerts        = false
  }
}
```

# Reference

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.20 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_branch.identified_by](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.for_pattern](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborators.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_branch_protections"></a> [branch\_protections](#input\_branch\_protections) | The branch protections to apply to the repository | <pre>map(object({<br>    allows_deletions                = optional(bool, false)<br>    allows_force_pushes             = optional(bool, false)<br>    blocks_creations                = optional(bool, false)<br>    enforce_admins                  = optional(bool, true)<br>    lock_branch                     = optional(bool, false)<br>    push_restrictions               = optional(set(string), [])<br>    require_conversation_resolution = optional(bool, true)<br>    require_signed_commits          = optional(bool, false)<br>    required_linear_history         = optional(bool, false)<br><br>    required_pull_request_reviews = optional(object({<br>      dismiss_stale_reviews           = optional(bool, true)<br>      dismissal_restrictions          = optional(set(number), [])<br>      pull_request_bypassers          = optional(set(string), [])<br>      require_code_owner_reviews      = optional(bool, true)<br>      required_approving_review_count = optional(number, 1)<br>      require_last_push_approval      = optional(bool, true)<br>      restrict_dismissals             = optional(bool, true)<br>    }), {})<br>    required_status_checks = optional(object({<br>      contexts = optional(set(string), [])<br>      strict   = optional(bool, true)<br>    }), {})<br>  }))</pre> | `{}` | no |
| <a name="input_branches"></a> [branches](#input\_branches) | A map of branches to create in the repository | <pre>map(object({<br>    is_default    = optional(bool, false)<br>    source_branch = optional(string, null)<br>    source_sha    = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_collaborators"></a> [collaborators](#input\_collaborators) | n/a | <pre>object({<br>    teams = optional(object({<br>      admin    = optional(set(string), [])<br>      maintain = optional(set(string), [])<br>      pull     = optional(set(string), [])<br>      push     = optional(set(string), [])<br>      triage   = optional(set(string), [])<br>    }), {})<br>    users = optional(object({<br>      admin    = optional(set(string), [])<br>      maintain = optional(set(string), [])<br>      pull     = optional(set(string), [])<br>      push     = optional(set(string), [])<br>      triage   = optional(set(string), [])<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the GitHub repository | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | The settings to apply to the repository | <pre>object({<br>    archived           = optional(bool, false)<br>    auto_init          = optional(bool, true)<br>    description        = optional(string, null)<br>    gitignore_template = optional(string, null)<br>    homepage_url       = optional(string, null)<br>    is_template        = optional(bool, false)<br>    license_template   = optional(string, null)<br>    topics             = optional(set(string), [])<br>    visibility         = optional(string, "private")<br><br>    template = optional(object({<br>      owner      = string<br>      repository = string<br>    }))<br><br>    ## Feature Configuration<br>    has_discussions = optional(bool, false)<br>    has_issues      = optional(bool, true)<br>    has_projects    = optional(bool, false)<br>    has_wiki        = optional(bool, false)<br><br>    pages = optional(object({<br>      source = object({<br>        branch = optional(string, "main")<br>        path   = optional(string, "/")<br>      })<br>      cname = optional(string, null)<br>    }))<br><br>    ## Policy Configuration<br>    allow_auto_merge            = optional(bool, false)<br>    allow_merge_commit          = optional(bool, true)<br>    allow_rebase_merge          = optional(bool, true)<br>    allow_squash_merge          = optional(bool, true)<br>    allow_update_branch         = optional(bool, true)<br>    archive_on_destroy          = optional(bool, true)<br>    delete_branch_on_merge      = optional(bool, true)<br>    merge_commit_message        = optional(string, "BLANK")<br>    merge_commit_title          = optional(string, "PR_TITLE")<br>    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")<br>    squash_merge_commit_title   = optional(string, "PR_TITLE")<br>    vulnerability_alerts        = optional(bool, true)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_branch_protections"></a> [branch\_protections](#output\_branch\_protections) | A map of the branch protections |
| <a name="output_settings"></a> [settings](#output\_settings) | A map of the repository settings |
<!-- END_TF_DOCS -->
