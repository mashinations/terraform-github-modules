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
