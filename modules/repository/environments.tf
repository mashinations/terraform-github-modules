resource "github_repository_environment" "identified_by" {
  depends_on = [github_repository.this, github_repository_collaborators.this]
  for_each   = var.environments

  environment = each.key
  repository  = github_repository.this.name
  wait_timer  = each.value.wait_timer

  deployment_branch_policy {
    custom_branch_policies = each.value.deployment_branch_policy.custom_branch_policies
    protected_branches     = each.value.deployment_branch_policy.protected_branches
  }

  reviewers {
    teams = each.value.reviewers.teams
    users = each.value.reviewers.users
  }
}
