resource "github_branch_protection" "for_pattern" {
  for_each = var.branch_protections

  pattern       = each.key
  repository_id = github_repository.this.node_id

  allows_deletions                = each.value.allows_deletions
  allows_force_pushes             = each.value.allows_force_pushes
  blocks_creations                = each.value.blocks_creations
  enforce_admins                  = each.value.enforce_admins
  lock_branch                     = each.value.lock_branch
  push_restrictions               = each.value.push_restrictions
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
}
