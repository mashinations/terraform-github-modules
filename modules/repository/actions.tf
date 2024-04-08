resource "github_actions_repository_permissions" "this" {
  repository = github_repository.this.name

  allowed_actions = var.actions.allowed_actions
  enabled         = var.actions.enabled

  dynamic "allowed_actions_config" {
    for_each = var.actions.allowed_actions == "selected" ? var.actions.allowed_actions_config[*] : []

    content {
      github_owned_allowed = allowed_actions_config.value.github_owned_allowed
      patterns_allowed     = allowed_actions_config.value.patterns_allowed
      verified_allowed     = allowed_actions_config.value.verified_allowed
    }
  }
}

resource "github_actions_secret" "identified_by" {
  depends_on = [github_repository.this]
  for_each   = var.actions.secrets

  repository  = github_repository.this.name
  secret_name = each.key

  encrypted_value = each.value.value_type == "encrypted" ? each.value.value : null
  plaintext_value = each.value.value_type == "plaintext" ? each.value.value : null
}

resource "github_actions_variable" "identified_by" {
  depends_on = [github_repository.this]
  for_each   = var.actions.variables

  repository    = github_repository.this.name
  variable_name = each.key

  value = each.value.value
}
