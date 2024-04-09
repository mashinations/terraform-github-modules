resource "github_branch_default" "this" {
  count = var.branches.default != null ? 1 : 0

  branch     = var.branches.default
  repository = github_repository.this.name

  ## The default branch is always renamed, rather than being
  ## created/swapped, preventing scenarios in which a branch
  ## could be unexpectedly/unintentionally deleted.
  rename = true
}
resource "github_branch" "identified_by" {
  depends_on = [github_branch_default.this]
  for_each   = var.branches.managed

  branch        = each.key
  repository    = github_repository.this.name
  source_branch = each.value.source_branch
  source_sha    = each.value.source_sha
}

resource "github_branch_protection" "for_pattern" {
  depends_on = [github_branch.identified_by]
  for_each   = var.branch_protections

  pattern       = each.key
  repository_id = github_repository.this.node_id

  allows_deletions                = each.value.allows_deletions
  allows_force_pushes             = each.value.allows_force_pushes
  enforce_admins                  = each.value.enforce_admins
  force_push_bypassers            = each.value.force_push_bypassers
  lock_branch                     = each.value.lock_branch
  require_conversation_resolution = each.value.require_conversation_resolution
  require_signed_commits          = each.value.require_signed_commits
  required_linear_history         = each.value.required_linear_history

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews[*]

    content {
      dismiss_stale_reviews           = required_pull_request_reviews.value.dismiss_stale_reviews
      dismissal_restrictions          = required_pull_request_reviews.value.dismissal_restrictions
      pull_request_bypassers          = required_pull_request_reviews.value.pull_request_bypassers
      require_code_owner_reviews      = required_pull_request_reviews.value.require_code_owner_reviews
      required_approving_review_count = required_pull_request_reviews.value.required_approving_review_count
      require_last_push_approval      = required_pull_request_reviews.value.require_last_push_approval
      restrict_dismissals             = required_pull_request_reviews.value.restrict_dismissals
    }
  }

  dynamic "required_status_checks" {
    for_each = each.value.required_status_checks[*]

    content {
      contexts = required_status_checks.value.contexts
      strict   = required_status_checks.value.strict
    }
  }

  dynamic "restrict_pushes" {
    for_each = each.value.restrict_pushes[*]

    content {
      blocks_creations = restrict_pushes.value.blocks_creations
      push_allowances  = restrict_pushes.value.push_allowances
    }
  }
}
