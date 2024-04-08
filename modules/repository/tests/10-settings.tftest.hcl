run "_setup_" {
  command = apply
  module { source = "./tests/setup" }
  variables { test_suite = "settings" }
}

## ============================================================================================== ##
##                          Test - Default Values for Repository Settings                         ##
## ============================================================================================== ##
run "check_defaults" {
  command = apply
  variables {
    name     = run._setup_.repository_name
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  ## Basic Configuration
  assert { ## output.settings.archived
    condition     = output.settings.archived == false
    error_message = "Default value for 'archived' should be 'false'"
  }
  assert { ## output.settings.auto_init
    condition     = output.settings.auto_init == true
    error_message = "Default value for 'auto_init' should be 'true'"
  }
  assert { ## output.settings.description
    condition     = output.settings.description == ""
    error_message = "Default value for 'description' should be empty"
  }
  assert { ## output.settings.gitignore_template
    condition     = output.settings.gitignore_template == null
    error_message = "Default value for 'gitignore_template' should be empty"
  }
  assert { ## output.settings.homepage_url
    condition     = output.settings.homepage_url == ""
    error_message = "Default value for 'homepage_url' should be empty"
  }
  assert { ## output.settings.is_template
    condition     = output.settings.is_template == false
    error_message = "Default value for 'is_template' should be 'false'"
  }
  assert { ## output.settings.license_template
    condition     = output.settings.license_template == null
    error_message = "Default value for 'license_template' should be empty"
  }
  assert { ## output.settings.topics
    condition     = length(output.settings.topics) == 0
    error_message = "Default value for 'topics' should be empty"
  }
  assert { ## output.settings.visibility
    condition     = output.settings.visibility == "private"
    error_message = "Default value for 'visibility' should be 'private'"
  }

  assert { ## output.settings.template
    condition     = length(output.settings.template) == 0
    error_message = "Default value for 'template' should be empty"
  }

  ## Basic Configuration - Repository Features
  assert { ## output.settings.has_discussions
    condition     = output.settings.has_discussions == false
    error_message = "Default value for 'has_discussions' should be 'false'"
  }
  assert { ## output.settings.has_issues
    condition     = output.settings.has_issues == true
    error_message = "Default value for 'has_issues' should be 'true'"
  }
  assert { ## output.settings.has_projects
    condition     = output.settings.has_projects == false
    error_message = "Default value for 'has_projects' should be 'false'"
  }
  assert { ## output.settings.has_wiki
    condition     = output.settings.has_wiki == false
    error_message = "Default value for 'has_wiki' should be 'false'"
  }

  assert { ## output.settings.pages
    condition     = length(output.settings.pages) == 0
    error_message = "Default value for 'pages' should be empty"
  }

  ## Basic Configuration - Repository Policies
  assert { ## output.settings.allow_auto_merge
    condition     = output.settings.allow_auto_merge == false
    error_message = "Default value for 'allow_auto_merge' should be 'false'"
  }
  assert { ## output.settings.allow_merge_commit
    condition     = output.settings.allow_merge_commit == true
    error_message = "Default value for 'allow_merge_commit' should be 'true'"
  }
  assert { ## output.settings.allow_rebase_merge
    condition     = output.settings.allow_rebase_merge == true
    error_message = "Default value for 'allow_rebase_merge' should be 'true'"
  }
  assert { ## output.settings.allow_squash_merge
    condition     = output.settings.allow_squash_merge == true
    error_message = "Default value for 'allow_squash_merge' should be 'true'"
  }
  assert { ## output.settings.allow_update_branch
    condition     = output.settings.allow_update_branch == true
    error_message = "Default value for 'allow_update_branch' should be 'true'"
  }
  assert { ## output.settings.archive_on_destroy
    condition     = output.settings.archive_on_destroy == run._setup_.archive_repository
    error_message = "Default value for 'archive_on_destroy' should be '${run._setup_.archive_repository}'"
  }
  assert { ## output.settings.default_branch
    condition     = output.settings.default_branch == "main"
    error_message = "Default value for 'default_branch' should be 'main'"
  }
  assert { ## output.settings.delete_branch_on_merge
    condition     = output.settings.delete_branch_on_merge == true
    error_message = "Default value for 'delete_branch_on_merge' should be 'true'"
  }
  assert { ## output.settings.merge_commit_message
    condition     = output.settings.merge_commit_message == "BLANK"
    error_message = "Default value for 'merge_commit_message' should be 'BLANK'"
  }
  assert { ## output.settings.merge_commit_title
    condition     = output.settings.merge_commit_title == "PR_TITLE"
    error_message = "Default value for 'merge_commit_title' should be 'PR_TITLE'"
  }
  assert { ## output.settings.squash_merge_commit_message
    condition     = output.settings.squash_merge_commit_message == "COMMIT_MESSAGES"
    error_message = "Default value for 'squash_merge_commit_message' should be 'COMMIT_MESSAGES'"
  }
  assert { ## output.settings.squash_merge_commit_title
    condition     = output.settings.squash_merge_commit_title == "PR_TITLE"
    error_message = "Default value for 'squash_merge_commit_title' should be 'PR_TITLE'"
  }
  assert { ## output.settings.vulnerability_alerts
    condition     = output.settings.vulnerability_alerts == true
    error_message = "Default value for 'vulnerability_alerts' should be 'true'"
  }
  assert { ## output.settings.web_commit_signoff_required
    condition     = output.settings.web_commit_signoff_required == false
    error_message = "Default value for 'web_commit_signoff_required' should be 'false'"
  }

  assert { ## output.settings.security_and_analysis
    condition     = length(output.settings.security_and_analysis) == 0
    error_message = "Default value for 'security_and_analysis' should be empty"
  }
}
