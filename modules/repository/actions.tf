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
