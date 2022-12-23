> **WARNING**
> This module is in development and should not be considered stable until v1.0.0 is released or is otherwise indicated by the removal of this message from the documentation.

A Terraform module to manage a GitHub organization.

# Features

- **Settings** - Manage the organization's policies and settings

# Getting Started

```hcl
module "example" {
    source = "github.com/mashinations/terraform-github//modules/organization?ref=master"

    billing_email = "example@example.com

    settings = {
        blog             = "https://example.com/blog"
        company          = "Example, Inc."
        description      = "Example Organization"
        email            = "admin@example.com"
        location         = "San Francisco, CA"
        name             = "Example"
        twitter_username = "@example"

        ## GitHub Settings
        default_repository_permission           = "read"
        dependabot_alerts_enabled               = true
        dependency_graph_enabled                = true
        has_organization_projects               = false
        has_repository_projects                 = false
        members_can_create_pages                = false
        members_can_create_private_pages        = false
        members_can_create_private_repositories = false
        members_can_create_public_pages         = false
        members_can_create_public_repositories  = false
        members_can_create_repositories         = false
        members_can_fork_private_repositories   = false
        secret_scanning_enabled                 = true
        web_commit_signoff_required             = false

        ## GitHub Enterprise Settings
        advanced_security_enabled                = false
        members_can_create_internal_repositories = false
    }
}
```

# Reference

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_organization_settings.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_settings) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_email"></a> [billing\_email](#input\_billing\_email) | The billing email for the organization | `string` | n/a | yes |
| <a name="input_settings"></a> [settings](#input\_settings) | The settings to apply to the organization | <pre>object({<br>    blog             = optional(string)<br>    company          = optional(string)<br>    description      = optional(string)<br>    email            = optional(string)<br>    location         = optional(string)<br>    name             = optional(string)<br>    twitter_username = optional(string)<br><br>    ## GitHub Settings<br>    default_repository_permission           = optional(string, "read")<br>    dependabot_alerts_enabled               = optional(bool, true)<br>    dependency_graph_enabled                = optional(bool, true)<br>    has_organization_projects               = optional(bool, false)<br>    has_repository_projects                 = optional(bool, false)<br>    members_can_create_pages                = optional(bool, false)<br>    members_can_create_private_pages        = optional(bool, false)<br>    members_can_create_private_repositories = optional(bool, false)<br>    members_can_create_public_pages         = optional(bool, false)<br>    members_can_create_public_repositories  = optional(bool, false)<br>    members_can_create_repositories         = optional(bool, false)<br>    members_can_fork_private_repositories   = optional(bool, false)<br>    secret_scanning_enabled                 = optional(bool, true)<br>    web_commit_signoff_required             = optional(bool, false)<br><br>    ## GitHub Enterprise Settings<br>    advanced_security_enabled                = optional(bool, false)<br>    members_can_create_internal_repositories = optional(bool, false)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_settings"></a> [settings](#output\_settings) | A map of the organization settings for reference |
<!-- END_TF_DOCS -->
