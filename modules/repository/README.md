> **WARNING**
> This module is in development and should not be considered stable until v1.0.0 is released or is otherwise indicated by the removal of this message from the documentation.

A Terraform module to create and manage a GitHub repository and various repository-related features.


# Features

In addition to creating the specified repository, the following features are supported:

- **Actions** - Manage Actions secrets, variables, and permissions
- **Branch Management** - Create branches and optionally designate one as the default branch
- **Branch Protections** - Create branch protections for branches matching the specified pattern(s)
- **Collaborators** - Grant teams or users access to the repository with the specified permissions
- **Dependabot** - Manage Dependabot secrets
- **Environments** - Manage the repository's environments and associated secrets/variables
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

  environments = {
    dev = {
      deployment_branch_policy = {
        custom_branch_policies = false
        protected_branches     = true
      }
      reviewers  = { teams = [1234567890], users = [1234567890] }
      secrets = {
        EXAMPLE_SECRET_ENCRYPTED = { value = "15/KSzApItoMU5Gieg" }
        EXAMPLE_SECRET_PLAINTEXT = { value = "EXAMPLE_SECRET_PLAINTEXT", value_type = "plaintext" }
      }
      variables = {
        EXAMPLE_VARIABLE = { value = "EXAMPLE_VARIABLE" }
      }
      wait_timer = 120
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

  actions = {
    allowed_actions = "selected"
    allowed_actions_config = {
      github_owned_allowed = true
      patterns_allowed     = ["example-org/*"]
      verified_allowed     = true
    }
    secrets = {
      EXAMPLE_SECRET_ENCRYPTED = { value = "15/KSzApItoMU5Gieg" }
      EXAMPLE_SECRET_PLAINTEXT = { value = "EXAMPLE_SECRET_PLAINTEXT", value_type = "plaintext" }
    }
    variables = {
      EXAMPLE_VARIABLE = { value = "EXAMPLE_VARIABLE" }
    }
  }
  dependabot = {
    secrets = {
      EXAMPLE_SECRET_ENCRYPTED = { value = "15/KSzApItoMU5Gieg" }
      EXAMPLE_SECRET_PLAINTEXT = { value = "EXAMPLE_SECRET_PLAINTEXT", value_type = "plaintext" }
    }
  }
}
```

# Reference

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_environment_secret.identified_by](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret) | resource |
| [github_actions_environment_variable.identified_by](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_actions_repository_permissions.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions) | resource |
| [github_actions_secret.identified_by](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_variable.identified_by](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_branch.identified_by](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) | resource |
| [github_branch_default.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.for_pattern](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_dependabot_secret.identified_by](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_secret) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_collaborators.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_collaborators) | resource |
| [github_repository_environment.identified_by](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions"></a> [actions](#input\_actions) | An object containing configuration settings for GitHub Actions | <pre>object({<br>    allowed_actions = optional(string, "all")<br>    allowed_actions_config = optional(object({<br>      github_owned_allowed = optional(bool, true)<br>      patterns_allowed     = optional(set(string), null)<br>      verified_allowed     = optional(bool, true)<br>    }), {})<br>    secrets = optional(map(object({<br>      value      = string<br>      value_type = optional(string, "encrypted")<br>    })), {})<br>    variables = optional(map(object({<br>      value = string<br>    })), {})<br>  })</pre> | `{}` | no |
| <a name="input_branch_protections"></a> [branch\_protections](#input\_branch\_protections) | The branch protections to apply to the repository | <pre>map(object({<br>    allows_deletions                = optional(bool, false)<br>    allows_force_pushes             = optional(bool, false)<br>    enforce_admins                  = optional(bool, true)<br>    lock_branch                     = optional(bool, false)<br>    require_conversation_resolution = optional(bool, true)<br>    require_signed_commits          = optional(bool, false)<br>    required_linear_history         = optional(bool, false)<br><br>    required_pull_request_reviews = optional(object({<br>      dismiss_stale_reviews           = optional(bool, true)<br>      dismissal_restrictions          = optional(set(number), [])<br>      pull_request_bypassers          = optional(set(string), [])<br>      require_code_owner_reviews      = optional(bool, true)<br>      required_approving_review_count = optional(number, 1)<br>      require_last_push_approval      = optional(bool, true)<br>      restrict_dismissals             = optional(bool, true)<br>    }), {})<br>    required_status_checks = optional(object({<br>      contexts = optional(set(string), [])<br>      strict   = optional(bool, true)<br>    }), {})<br>    restrict_pushes = optional(object({<br>      blocks_creations = optional(bool, false)<br>      push_allowances  = optional(set(string), [])<br>    }), {})<br>  }))</pre> | `{}` | no |
| <a name="input_branches"></a> [branches](#input\_branches) | A map of branches to create in the repository | <pre>map(object({<br>    is_default    = optional(bool, false)<br>    source_branch = optional(string, null)<br>    source_sha    = optional(string, null)<br>  }))</pre> | `{}` | no |
| <a name="input_collaborators"></a> [collaborators](#input\_collaborators) | The teams and users to add as collaborators to the repository | <pre>object({<br>    teams = optional(object({<br>      admin    = optional(set(string), [])<br>      maintain = optional(set(string), [])<br>      pull     = optional(set(string), [])<br>      push     = optional(set(string), [])<br>      triage   = optional(set(string), [])<br>    }), {})<br>    users = optional(object({<br>      admin    = optional(set(string), [])<br>      maintain = optional(set(string), [])<br>      pull     = optional(set(string), [])<br>      push     = optional(set(string), [])<br>      triage   = optional(set(string), [])<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_dependabot"></a> [dependabot](#input\_dependabot) | An object containing configuration settings for GitHub Dependabot | <pre>object({<br>    secrets = optional(map(object({<br>      value      = string<br>      value_type = optional(string, "encrypted")<br>    })), {})<br>  })</pre> | `{}` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | The environments to create and manage for the repository | <pre>map(object({<br>    deployment_branch_policy = optional(object({<br>      custom_branch_policies = optional(bool, false)<br>      protected_branches     = optional(bool, true)<br>    }), {})<br>    reviewers = optional(object({<br>      teams = optional(set(number), [])<br>      users = optional(set(number), [])<br>    }), {})<br>    secrets = optional(map(object({<br>      value      = string<br>      value_type = optional(string, "encrypted")<br>    })), {})<br>    variables = optional(map(object({<br>      value = string<br>    })), {})<br>    wait_timer = optional(number, null)<br>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the GitHub repository | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | The settings to apply to the repository | <pre>object({<br>    archived           = optional(bool, false)<br>    auto_init          = optional(bool, true)<br>    description        = optional(string, null)<br>    gitignore_template = optional(string, null)<br>    homepage_url       = optional(string, null)<br>    is_template        = optional(bool, false)<br>    license_template   = optional(string, null)<br>    topics             = optional(set(string), [])<br>    visibility         = optional(string, "private")<br><br>    template = optional(object({<br>      owner      = string<br>      repository = string<br>    }))<br><br>    ## Feature Configuration<br>    has_discussions = optional(bool, false)<br>    has_issues      = optional(bool, true)<br>    has_projects    = optional(bool, false)<br>    has_wiki        = optional(bool, false)<br><br>    pages = optional(object({<br>      source = object({<br>        branch = optional(string, "main")<br>        path   = optional(string, "/")<br>      })<br>      cname = optional(string, null)<br>    }))<br><br>    ## Policy Configuration<br>    allow_auto_merge            = optional(bool, false)<br>    allow_merge_commit          = optional(bool, true)<br>    allow_rebase_merge          = optional(bool, true)<br>    allow_squash_merge          = optional(bool, true)<br>    allow_update_branch         = optional(bool, true)<br>    archive_on_destroy          = optional(bool, true)<br>    delete_branch_on_merge      = optional(bool, true)<br>    merge_commit_message        = optional(string, "BLANK")<br>    merge_commit_title          = optional(string, "PR_TITLE")<br>    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")<br>    squash_merge_commit_title   = optional(string, "PR_TITLE")<br>    vulnerability_alerts        = optional(bool, true)<br>    web_commit_signoff_required = optional(bool, false)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_actions_permissions"></a> [actions\_permissions](#output\_actions\_permissions) | The current permissions for Actions |
| <a name="output_actions_secrets"></a> [actions\_secrets](#output\_actions\_secrets) | A map of Actions secret objects keyed by secret name |
| <a name="output_actions_variables"></a> [actions\_variables](#output\_actions\_variables) | A map of Actions variable objects keyed by variable name |
| <a name="output_branch_protections"></a> [branch\_protections](#output\_branch\_protections) | A map of branch protection objects keyed by pattern |
| <a name="output_branches"></a> [branches](#output\_branches) | A map of branch objects keyed by branch name |
| <a name="output_collaborators"></a> [collaborators](#output\_collaborators) | The collaborators object listing teams and users with access |
| <a name="output_dependabot_secrets"></a> [dependabot\_secrets](#output\_dependabot\_secrets) | A map of Dependabot secret objects keyed by secret name |
| <a name="output_environment_secrets"></a> [environment\_secrets](#output\_environment\_secrets) | A map of environment secret objects keyed by environment name and secret name |
| <a name="output_environment_variables"></a> [environment\_variables](#output\_environment\_variables) | A map of environment variable objects keyed by environment name and variable name |
| <a name="output_environments"></a> [environments](#output\_environments) | A map of environment objects keyed by environment name |
| <a name="output_settings"></a> [settings](#output\_settings) | The current settings for the repository |
<!-- END_TF_DOCS -->
