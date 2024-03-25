resource "github_repository_environment" "identified_by" {
  depends_on = [github_repository.this, github_repository_collaborators.this]
  for_each   = var.environments

  environment = each.key
  repository  = github_repository.this.name

  can_admins_bypass   = each.value.can_admins_bypass
  prevent_self_review = each.value.prevent_self_review
  wait_timer          = each.value.wait_timer

  deployment_branch_policy {
    custom_branch_policies = each.value.deployment_branch_policy.custom_branch_policies
    protected_branches     = each.value.deployment_branch_policy.protected_branches
  }

  reviewers {
    teams = each.value.reviewers.teams
    users = each.value.reviewers.users
  }
}

resource "github_actions_environment_secret" "identified_by" {
  for_each = merge([
    for env, envCfg in var.environments : merge(
      { for secret, secretCfg in envCfg.secrets : "${env}:${secret}" => {
        env_name          = env
        secret_name       = secret
        secret_value      = secretCfg.value
        secret_value_type = secretCfg.value_type
        }
    })
  ]...)

  environment = github_repository_environment.identified_by[each.value.env_name].environment
  repository  = github_repository.this.name
  secret_name = each.value.secret_name

  encrypted_value = each.value.secret_value_type == "encrypted" ? each.value.secret_value : null
  plaintext_value = each.value.secret_value_type == "plaintext" ? each.value.secret_value : null
}

resource "github_actions_environment_variable" "identified_by" {
  for_each = merge([
    for env, envCfg in var.environments : merge(
      { for variable, variableCfg in envCfg.variables : "${env}:${variable}" => {
        env_name       = env
        variable_name  = variable
        variable_value = variableCfg.value
        }
    })
  ]...)

  environment = github_repository_environment.identified_by[each.value.env_name].environment
  repository  = github_repository.this.name

  value         = each.value.variable_value
  variable_name = each.value.variable_name
}
