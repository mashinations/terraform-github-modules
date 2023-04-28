resource "github_actions_organization_permissions" "this" {
  depends_on = [github_organization_settings.this]

  allowed_actions      = var.actions.allowed_actions
  enabled_repositories = var.actions.enabled_repositories

  dynamic "allowed_actions_config" {
    for_each = var.actions.allowed_actions == "selected" ? var.actions.allowed_actions_config[*] : []

    content {
      github_owned_allowed = allowed_actions_config.value.github_owned_allowed
      patterns_allowed     = allowed_actions_config.value.patterns_allowed
      verified_allowed     = allowed_actions_config.value.verified_allowed
    }
  }

  dynamic "enabled_repositories_config" {
    for_each = var.actions.enabled_repositories == "selected" ? var.actions.enabled_repositories_config[*] : []

    content {
      repository_ids = enabled_repositories_config.value.repository_ids
    }
  }
}

resource "github_actions_organization_secret" "identified_by" {
  depends_on = [github_organization_settings.this]
  for_each   = var.actions.secrets

  secret_name = each.key

  encrypted_value         = each.value.value_type == "encrypted" ? each.value.value : null
  plaintext_value         = each.value.value_type == "plaintext" ? each.value.value : null
  selected_repository_ids = each.value.repository_ids
  visibility              = each.value.visibility
}

resource "github_actions_organization_variable" "identified_by" {
  depends_on = [github_organization_settings.this]
  for_each   = var.actions.variables

  variable_name = each.key

  selected_repository_ids = each.value.repository_ids
  value                   = each.value.value
  visibility              = each.value.visibility
}
