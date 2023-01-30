> **WARNING**
> This module is in development and should not be considered stable until v1.0.0 is released or is otherwise indicated by the removal of this message from the documentation.

A Terraform module to create and manage a GitHub repository.


# Features

In addition to creating the specified repository, the following features are supported:

- **Settings** - Manage the repository's policies and settings

# Getting Started

Basic usage of this module is as follows:

```hcl
module "example" {
  source = "github.com/mashinations/terraform-github//modules/repository?ref=master"

  name = "example-repository"

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
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.15 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.15 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the GitHub repository | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | The settings to apply to the repository | <pre>object({<br>    archived           = optional(bool, false)<br>    auto_init          = optional(bool, true)<br>    description        = optional(string, null)<br>    gitignore_template = optional(string, null)<br>    homepage_url       = optional(string, null)<br>    is_template        = optional(bool, false)<br>    license_template   = optional(string, null)<br>    topics             = optional(set(string), [])<br>    visibility         = optional(string, "private")<br><br>    template = optional(object({<br>      owner      = string<br>      repository = string<br>    }))<br><br>    ## Feature Configuration<br>    has_discussions = optional(bool, false)<br>    has_issues      = optional(bool, true)<br>    has_projects    = optional(bool, false)<br>    has_wiki        = optional(bool, false)<br><br>    pages = optional(object({<br>      source = object({<br>        branch = optional(string, "main")<br>        path   = optional(string, "/")<br>      })<br>      cname = optional(string, null)<br>    }))<br><br>    ## Policy Configuration<br>    allow_auto_merge            = optional(bool, false)<br>    allow_merge_commit          = optional(bool, true)<br>    allow_rebase_merge          = optional(bool, true)<br>    allow_squash_merge          = optional(bool, true)<br>    allow_update_branch         = optional(bool, true)<br>    archive_on_destroy          = optional(bool, true)<br>    delete_branch_on_merge      = optional(bool, true)<br>    merge_commit_message        = optional(string, "BLANK")<br>    merge_commit_title          = optional(string, "PR_TITLE")<br>    squash_merge_commit_message = optional(string, "COMMIT_MESSAGES")<br>    squash_merge_commit_title   = optional(string, "PR_TITLE")<br>    vulnerability_alerts        = optional(bool, true)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_settings"></a> [settings](#output\_settings) | A map of the repository settings |
<!-- END_TF_DOCS -->