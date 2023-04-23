> **WARNING**
> This module is in development and should not be considered stable until v1.0.0 is released or is otherwise indicated by the removal of this message from the documentation.

A Terraform module to manage a GitHub organization.

# Features

- **Membership** - Manage the organization's members and their roles
- **Moderation** - Manage the organization's blocked users
- **Secrets** - Manage the organization's Actions and Dependabot secrets
- **Settings** - Manage the organization's policies and settings

# Getting Started

```hcl
module "example" {
    source = "github.com/mashinations/terraform-github//modules/organization?ref=main"

    billing_email = "example@example.com
    blocked_users = [ "example-blocked-user" ]

    admins            = [ "example-admin" ]
    members           = [ "example-user" ]
    security_managers = [ "example-security-manager" ]

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
        dependabot_security_updates_enabled     = true
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
        secret_scanning_push_protection_enabled  = false
    }

    actions_secrets = {
        EXAMPLE_SECRET = {
            encrypted_value = "igloQnADqDsndt+KTvoUF6iiPt/IndvcGRInLs2v72c7Dnm6ktLyTceWcNvQVU9dEdMp3gkTfXIlA2UlPpo="
            visibility      = "private"
        }
    }
    dependabot_secrets = {
        EXAMPLE_SECRET = {
            encrypted_value = "igloQnADqDsndt+KTvoUF6iiPt/IndvcGRInLs2v72c7Dnm6ktLyTceWcNvQVU9dEdMp3gkTfXIlA2UlPpo="
            visibility      = "private"
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
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.18 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_organization_secret.identified_by](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_secret) | resource |
| [github_dependabot_organization_secret.identified_by](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_organization_secret) | resource |
| [github_membership.admins](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership) | resource |
| [github_membership.members](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership) | resource |
| [github_membership.security_managers](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/membership) | resource |
| [github_organization_block.user](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_block) | resource |
| [github_organization_security_manager.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_security_manager) | resource |
| [github_organization_settings.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_settings) | resource |
| [github_team.admins](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team.members](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team.security_managers](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team_members.admins](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) | resource |
| [github_team_members.members](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) | resource |
| [github_team_members.security_managers](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) | resource |
| [github_users.admins](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/users) | data source |
| [github_users.members](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/users) | data source |
| [github_users.security_managers](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/users) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions_secrets"></a> [actions\_secrets](#input\_actions\_secrets) | A map of secrets to add to the organization for Actions | <pre>map(object({<br>    encrypted_value = string<br>    repository_ids  = optional(set(string), null)<br>    visibility      = optional(string, "private")<br>  }))</pre> | `null` | no |
| <a name="input_admins"></a> [admins](#input\_admins) | The users to add to the organization with the 'admin' role. | `set(string)` | `[]` | no |
| <a name="input_admins_team"></a> [admins\_team](#input\_admins\_team) | The team to create and add all admins to. | <pre>object({<br>    name        = string<br>    description = optional(string, "Managed by Terraform")<br>    visibility  = optional(string, "closed")<br>  })</pre> | `null` | no |
| <a name="input_billing_email"></a> [billing\_email](#input\_billing\_email) | The billing email for the organization | `string` | n/a | yes |
| <a name="input_blocked_users"></a> [blocked\_users](#input\_blocked\_users) | The users to block from the organization | `set(string)` | `[]` | no |
| <a name="input_dependabot_secrets"></a> [dependabot\_secrets](#input\_dependabot\_secrets) | A map of secrets to add to the organization for Dependabot | <pre>map(object({<br>    encrypted_value = string<br>    repository_ids  = optional(set(string), null)<br>    visibility      = optional(string, "private")<br>  }))</pre> | `null` | no |
| <a name="input_members"></a> [members](#input\_members) | The users to add to the organization with the 'member' role. | `set(string)` | `[]` | no |
| <a name="input_members_team"></a> [members\_team](#input\_members\_team) | The team to create and add all members to. | <pre>object({<br>    name        = string<br>    description = optional(string, "Managed by Terraform")<br>    visibility  = optional(string, "closed")<br>  })</pre> | `null` | no |
| <a name="input_security_managers"></a> [security\_managers](#input\_security\_managers) | The users to add to the organization as security managers. | `set(string)` | `[]` | no |
| <a name="input_security_managers_team"></a> [security\_managers\_team](#input\_security\_managers\_team) | The team to create and add all security managers to. | <pre>object({<br>    name        = string<br>    description = optional(string, "Managed by Terraform")<br>    visibility  = optional(string, "closed")<br>  })</pre> | `null` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | The settings to apply to the organization | <pre>object({<br>    blog             = optional(string)<br>    company          = optional(string)<br>    description      = optional(string)<br>    email            = optional(string)<br>    location         = optional(string)<br>    name             = optional(string)<br>    twitter_username = optional(string)<br><br>    ## GitHub Settings<br>    default_repository_permission           = optional(string, "read")<br>    dependabot_alerts_enabled               = optional(bool, true)<br>    dependabot_security_updates_enabled     = optional(bool, true)<br>    dependency_graph_enabled                = optional(bool, true)<br>    has_organization_projects               = optional(bool, false)<br>    has_repository_projects                 = optional(bool, false)<br>    members_can_create_pages                = optional(bool, false)<br>    members_can_create_private_pages        = optional(bool, false)<br>    members_can_create_private_repositories = optional(bool, false)<br>    members_can_create_public_pages         = optional(bool, false)<br>    members_can_create_public_repositories  = optional(bool, false)<br>    members_can_create_repositories         = optional(bool, false)<br>    members_can_fork_private_repositories   = optional(bool, false)<br>    secret_scanning_enabled                 = optional(bool, true)<br>    web_commit_signoff_required             = optional(bool, false)<br><br>    ## GitHub Enterprise Settings<br>    advanced_security_enabled                = optional(bool, false)<br>    members_can_create_internal_repositories = optional(bool, false)<br>    secret_scanning_push_protection_enabled  = optional(bool, false)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_actions_secrets"></a> [actions\_secrets](#output\_actions\_secrets) | A map of the organization's actions secrets |
| <a name="output_admins"></a> [admins](#output\_admins) | A map of users added to the organization with the `admin` role |
| <a name="output_admins_team"></a> [admins\_team](#output\_admins\_team) | The team created for admins, if requested |
| <a name="output_dependabot_secrets"></a> [dependabot\_secrets](#output\_dependabot\_secrets) | A map of the organization's dependabot secrets |
| <a name="output_members"></a> [members](#output\_members) | A map of users added to the organization with the `member` role |
| <a name="output_members_team"></a> [members\_team](#output\_members\_team) | The team created for members, if requested |
| <a name="output_security_managers"></a> [security\_managers](#output\_security\_managers) | A map of users added to the organization with the `security manager` role |
| <a name="output_security_managers_team"></a> [security\_managers\_team](#output\_security\_managers\_team) | The team created for security managers, if requested |
| <a name="output_settings"></a> [settings](#output\_settings) | A map of the organization settings for reference |
<!-- END_TF_DOCS -->
