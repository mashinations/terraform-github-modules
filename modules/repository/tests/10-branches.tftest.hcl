run "_setup_" {
  command = apply
  module { source = "./tests/setup" }
  variables { test_suite = "branches" }
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

  assert { ## output.branches
    condition     = length(output.branches) == 0
    error_message = "Default value for 'branches' should be empty"
  }

  assert { ## output.branch_default
    condition     = output.branch_default == null
    error_message = "Default value for 'branch_default' should be empty"
  }

  assert { ## output.branch_protections
    condition     = length(output.branch_protections) == 0
    error_message = "Default value for 'branch_protections' should be empty"
  }
}

## ============================================================================================== ##
##                      Test - Feature Configuration - Change Default Branch                      ##
## ============================================================================================== ##
run "check_feature_change_default_branch" {
  command = apply
  variables {
    name     = run._setup_.repository_name
    branches = { default = "default" }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.branches
    condition     = length(output.branches) == 0
    error_message = "Value for 'branches' should be empty"
  }

  assert { ## output.branch_default
    condition     = output.branch_default != null
    error_message = "Value for 'branch_default' should not be empty"
  }
  assert { ## output.branch_default.branch
    condition     = output.branch_default.branch == "default"
    error_message = "Value for 'branch_default.branch' should be 'default'"
  }
  assert { ## output.branch_default.rename
    condition     = output.branch_default.rename == true
    error_message = "Value for 'branch_default.rename' should be 'true'"
  }
  assert { ## output.branch_default.repository
    condition     = output.branch_default.repository == run._setup_.repository_name
    error_message = "Value for 'branches_default.repository' should be '${run._setup_.repository_name}'"
  }

  assert { ## output.branch_protections
    condition     = length(output.branch_protections) == 0
    error_message = "Default value for 'branch_protections' should be empty"
  }
}

## ============================================================================================== ##
##                      Test - Feature Configuration - Create Managed Branch                      ##
## ============================================================================================== ##
run "check_feature_create_managed_branch" {
  command = apply
  variables {
    name = run._setup_.repository_name
    branches = {
      default = "main"
      managed = { devel = {} }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.branches
    condition     = length(output.branches) == 1
    error_message = "Value for 'branches' should have 1 item"
  }

  assert { ## output.branches.devel
    condition     = lookup(output.branches, "devel", null) != null
    error_message = "Value for 'branches.devel' should not be 'null'"
  }
  assert { ## output.branches.devel.branch
    condition     = output.branches.devel.branch == "devel"
    error_message = "Value for 'branches.devel.branch' should be 'devel'"
  }
  assert { ## output.branches.devel.id
    condition     = output.branches.devel.id == "${run._setup_.repository_name}:devel"
    error_message = "Value for 'branches.devel.id' should be '${run._setup_.repository_name}:devel'"
  }
  assert { ## output.branches.devel.repository
    condition     = output.branches.devel.repository == run._setup_.repository_name
    error_message = "Value for 'branches.devel.repository' should be '${run._setup_.repository_name}'"
  }
  assert { ## output.branches.devel.source_branch
    condition     = output.branches.devel.source_branch == "main"
    error_message = "Value for 'branches.devel.source_branch' should be 'main'"
  }
}

## ============================================================================================== ##
##                        Test - Feature Configuration - Protected Branches                       ##
## ============================================================================================== ##
run "check_feature_protected_branches" {
  command = apply
  variables {
    name               = run._setup_.repository_name
    branches           = { default = "main" }
    branch_protections = { main = {} }
    // settings           = { visibility = "public" }
    settings = { archive_on_destroy = run._setup_.archive_repository, visibility = "public" }
  }

  assert { ## output.branch_protections
    condition     = length(output.branch_protections) == 1
    error_message = "Value for 'branch_protections' should have 1 item"
  }

  assert { ## output.branch_protections.main
    condition     = lookup(output.branch_protections, "main", null) != null
    error_message = "Value for 'branch_protections.main' should not be 'null'"
  }
  assert { ## output.branch_protections.main.pattern
    condition     = output.branch_protections.main.pattern == "main"
    error_message = "Value for 'branch_protections.main.pattern' should be 'main'"
  }

  assert { ## output.branch_protections.main.allows_deletions
    condition     = output.branch_protections.main.allows_deletions == false
    error_message = "Value for 'branch_protections.main.allows_deletions' should be 'false'"
  }
  assert { ## output.branch_protections.main.allows_force_pushes
    condition     = output.branch_protections.main.allows_force_pushes == false
    error_message = "Value for 'branch_protections.main.allows_force_pushes' should be 'false'"
  }
  assert { ## output.branch_protections.main.enforce_admins
    condition     = output.branch_protections.main.enforce_admins == true
    error_message = "Value for 'branch_protections.main.enforce_admins' should be 'true'"
  }
  assert { ## output.branch_protections.main.lock_branch
    condition     = output.branch_protections.main.lock_branch == false
    error_message = "Value for 'branch_protections.main.lock_branch' should be 'false'"
  }
  assert { ## output.branch_protections.main.require_conversation_resolution
    condition     = output.branch_protections.main.require_conversation_resolution == true
    error_message = "Value for 'branch_protections.main.require_conversation_resolution' should be 'true'"
  }
  assert { ## output.branch_protections.main.require_signed_commits
    condition     = output.branch_protections.main.require_signed_commits == false
    error_message = "Value for 'branch_protections.main.require_signed_commits' should be 'false'"
  }
  assert { ## output.branch_protections.main.required_linear_history
    condition     = output.branch_protections.main.required_linear_history == false
    error_message = "Value for 'branch_protections.main.required_linear_history' should be 'false'"
  }

  assert { ## output.branch_protections.main.required_pull_request_reviews
    condition     = length(output.branch_protections.main.required_pull_request_reviews) == 1
    error_message = "Value for 'branch_protections.main.required_pull_request_reviews' should have 1 item"
  }
  assert { ## output.branch_protections.main.required_pull_request_reviews[0]
    condition     = output.branch_protections.main.required_pull_request_reviews[0].dismiss_stale_reviews == true
    error_message = "Value for 'branch_protections.main.required_pull_request_reviews[0].dismiss_stale_reviews' should be 'true'"
  }
  assert { ## output.branch_protections.main.required_pull_request_reviews[0]
    condition     = output.branch_protections.main.required_pull_request_reviews[0].require_code_owner_reviews == true
    error_message = "Value for 'branch_protections.main.required_pull_request_reviews[0].require_code_owner_reviews' should be 'true'"
  }
  assert { ## output.branch_protections.main.required_pull_request_reviews[0]
    condition     = output.branch_protections.main.required_pull_request_reviews[0].require_last_push_approval == true
    error_message = "Value for 'branch_protections.main.required_pull_request_reviews[0].require_last_push_approval' should be 'true'"
  }
  assert { ## output.branch_protections.main.required_pull_request_reviews[0]
    condition     = output.branch_protections.main.required_pull_request_reviews[0].required_approving_review_count == 1
    error_message = "Value for 'branch_protections.main.required_pull_request_reviews[0].required_approving_review_count' should be '1'"
  }
  assert { ## output.branch_protections.main.required_pull_request_reviews[0]
    condition     = output.branch_protections.main.required_pull_request_reviews[0].restrict_dismissals == true
    error_message = "Value for 'branch_protections.main.required_pull_request_reviews[0].restrict_dismissals' should be 'true'"
  }

  assert { ## output.branch_protections.main.required_status_checks
    condition     = length(output.branch_protections.main.required_status_checks) == 1
    error_message = "Value for 'branch_protections.main.required_status_checks' should have 1 item"
  }
  assert { ## output.branch_protections.main.required_status_checks[0]
    condition     = output.branch_protections.main.required_status_checks[0].strict == true
    error_message = "Value for 'branch_protections.main.required_status_checks[0].strict' should be 'true'"
  }

  assert { ## output.branch_protections.main.restrict_pushes
    condition     = length(output.branch_protections.main.restrict_pushes) == 1
    error_message = "Value for 'branch_protections.main.restrict_pushes' should have 1 item"
  }
  assert { ## output.branch_protections.main.restrict_pushes[0]
    condition     = output.branch_protections.main.restrict_pushes[0].blocks_creations == false
    error_message = "Value for 'branch_protections.main.restrict_pushes[0].blocks_creations' should be 'false'"
  }
}
