run "_setup_" {
  command = apply
  module { source = "./tests/setup" }
  variables { test_suite = "base" }
}

## Ensure the module's default values remain unchanged, primarily to detect when
## breaking changes have been made and need to be called out in release notes or
## otherwise addressed.
run "test_defaults" {
  command = apply
  variables {
    name = run._setup_.repository_name
  }

  ## Basic Configuration
  assert { ## output.settings.archived
    condition     = output.settings.archived == false
    error_message = "Default value for the 'archived' field should be 'false'"
  }
  assert { ## output.settings.auto_init
    condition     = output.settings.auto_init == true
    error_message = "Default value for the 'auto_init' field should be 'true'"
  }
  assert { ## output.settings.description
    condition     = output.settings.description == ""
    error_message = "Default value for the 'description' field should be empty"
  }
  assert { ## output.settings.gitignore_template
    condition     = output.settings.gitignore_template == null
    error_message = "Default value for the 'gitignore_template' field should be empty"
  }
  assert { ## output.settings.homepage_url
    condition     = output.settings.homepage_url == ""
    error_message = "Default value for the 'homepage_url' field should be empty"
  }
  assert { ## output.settings.is_template
    condition     = output.settings.is_template == false
    error_message = "Default value for the 'is_template' field should be 'false'"
  }
  assert { ## output.settings.license_template
    condition     = output.settings.license_template == null
    error_message = "Default value for the 'license_template' field should be empty"
  }
  assert { ## output.settings.topics
    condition     = length(output.settings.topics) == 0
    error_message = "Default value for the 'topics' field should be empty"
  }
  assert { ## output.settings.visibility
    condition     = output.settings.visibility == "private"
    error_message = "Default value for the 'visibility' field should be 'private'"
  }

  assert { ## output.settings.template
    condition     = length(output.settings.template) == 0
    error_message = "Default value for the 'template' field should be empty"
  }

  ## Basic Configuration - Repository Features
  assert { ## output.settings.has_discussions
    condition     = output.settings.has_discussions == false
    error_message = "Default value for the 'has_discussions' field should be 'false'"
  }
  assert { ## output.settings.has_issues
    condition     = output.settings.has_issues == true
    error_message = "Default value for the 'has_issues' field should be 'true'"
  }
  assert { ## output.settings.has_projects
    condition     = output.settings.has_projects == false
    error_message = "Default value for the 'has_projects' field should be 'false'"
  }
  assert { ## output.settings.has_wiki
    condition     = output.settings.has_wiki == false
    error_message = "Default value for the 'has_wiki' field should be 'false'"
  }

  assert { ## output.settings.pages
    condition     = length(output.settings.pages) == 0
    error_message = "Default value for the 'pages' field should be empty"
  }

  ## Basic Configuration - Repository Policies
  assert { ## output.settings.allow_auto_merge
    condition     = output.settings.allow_auto_merge == false
    error_message = "Default value for the 'allow_auto_merge' field should be 'false'"
  }
  assert { ## output.settings.allow_merge_commit
    condition     = output.settings.allow_merge_commit == true
    error_message = "Default value for the 'allow_merge_commit' field should be 'true'"
  }
  assert { ## output.settings.allow_rebase_merge
    condition     = output.settings.allow_rebase_merge == true
    error_message = "Default value for the 'allow_rebase_merge' field should be 'true'"
  }
  assert { ## output.settings.allow_squash_merge
    condition     = output.settings.allow_squash_merge == true
    error_message = "Default value for the 'allow_squash_merge' field should be 'true'"
  }
  assert { ## output.settings.allow_update_branch
    condition     = output.settings.allow_update_branch == true
    error_message = "Default value for the 'allow_update_branch' field should be 'true'"
  }
  assert { ## output.settings.archive_on_destroy
    condition     = output.settings.archive_on_destroy == true
    error_message = "Default value for the 'archive_on_destroy' field should be 'true'"
  }
  assert { ## output.settings.default_branch
    condition     = output.settings.default_branch == "main"
    error_message = "Default value for the 'default_branch' field should be 'main'"
  }
  assert { ## output.settings.delete_branch_on_merge
    condition     = output.settings.delete_branch_on_merge == true
    error_message = "Default value for the 'delete_branch_on_merge' field should be 'true'"
  }
  assert { ## output.settings.merge_commit_message
    condition     = output.settings.merge_commit_message == "BLANK"
    error_message = "Default value for the 'merge_commit_message' field should be 'BLANK'"
  }
  assert { ## output.settings.merge_commit_title
    condition     = output.settings.merge_commit_title == "PR_TITLE"
    error_message = "Default value for the 'merge_commit_title' field should be 'PR_TITLE'"
  }
  assert { ## output.settings.squash_merge_commit_message
    condition     = output.settings.squash_merge_commit_message == "COMMIT_MESSAGES"
    error_message = "Default value for the 'squash_merge_commit_message' field should be 'COMMIT_MESSAGES'"
  }
  assert { ## output.settings.squash_merge_commit_title
    condition     = output.settings.squash_merge_commit_title == "PR_TITLE"
    error_message = "Default value for the 'squash_merge_commit_title' field should be 'PR_TITLE'"
  }
  assert { ## output.settings.vulnerability_alerts
    condition     = output.settings.vulnerability_alerts == true
    error_message = "Default value for the 'vulnerability_alerts' field should be 'true'"
  }
  assert { ## output.settings.web_commit_signoff_required
    condition     = output.settings.web_commit_signoff_required == false
    error_message = "Default value for the 'web_commit_signoff_required' field should be 'false'"
  }

  assert { ## output.settings.security_and_analysis
    condition     = length(output.settings.security_and_analysis) == 0
    error_message = "Default value for the 'security_and_analysis' field should be empty"
  }

  ## Feature Configuration - Actions
  assert { ## output.actions_permissions.allowed_actions
    condition     = output.actions_permissions.allowed_actions == "all"
    error_message = "Default value for the 'allowed_actions' field should be 'all'"
  }
  assert { ## output.actions_permissions.allowed_actions_config
    condition     = length(output.actions_permissions.allowed_actions_config) == 0
    error_message = "Default value for the 'allowed_actions_config' field should be empty"
  }
  assert { ## output.actions_permissions.enabled
    condition     = output.actions_permissions.enabled == true
    error_message = "Default value for the 'enabled' field should be 'true'"
  }
  assert { ## output.actions_permissions.repository
    condition     = output.actions_permissions.repository == run._setup_.repository_name
    error_message = "Default value for the 'repository' field should be '${run._setup_.repository_name}'"
  }
  assert { ## output.actions_secrets
    condition     = length(output.actions_secrets) == 0
    error_message = "Default value for the 'actions_secrets' field should be empty"
  }
  assert { ## output.actions_variables
    condition     = length(output.actions_variables) == 0
    error_message = "Default value for the 'actions_variables' field should be empty"

  }

  ## Feature Configuration - Branches and Branch Protections
  assert { ## output.branches
    condition     = length(output.branches) == 0
    error_message = "Default value for the 'branches' field should be empty"
  }
  assert { ## output.branch_protections
    condition     = length(output.branch_protections) == 0
    error_message = "Default value for the 'branch_protections' field should be empty"
  }

  ## Feature Configuration - Collaborators
  assert { ## output.collaborators.id
    condition     = output.collaborators.id == run._setup_.repository_name
    error_message = "Default value for the 'collaborators.id' field should be '${run._setup_.repository_name}'"
  }
  assert { ## output.collaborators.invitation_ids
    condition     = length(output.collaborators.invitation_ids) == 0
    error_message = "Default value for the 'collaborators.invitation_ids' field should be empty"
  }
  assert { ## output.collaborators.repository == run._setup_.repository_name
    condition     = output.collaborators.repository == run._setup_.repository_name
    error_message = "Default value for the 'collaborators.repository' field should be '${run._setup_.repository_name}'"
  }
  assert { ## output.collaborators.team
    condition     = length(output.collaborators.team) == 0
    error_message = "Default value for the 'collaborators.team' field should be empty"
  }
  assert { ## output.collsborators.user
    condition     = length(output.collaborators.user) == 0
    error_message = "Default value for the 'collaborators.user' field should be empty"
  }

  ## Feature Configuration - Dependabot
  assert { ## output.dependabot_secrets
    condition     = length(output.dependabot_secrets) == 0
    error_message = "Default value for the 'dependabot_secrets' field should be empty"
  }

  ## Feature Configuration - Environments
  assert { ## output.environments
    condition     = length(output.environments) == 0
    error_message = "Default value for the 'environments' field should be empty"
  }
  assert { ## output.environment_secrets
    condition     = length(output.environment_secrets) == 0
    error_message = "Default value for the 'environment_secrets' field should be empty"
  }
  assert { ## output.environment_variables
    condition     = length(output.environment_variables) == 0
    error_message = "Default value for the 'environment_variables' field should be empty"
  }
}
