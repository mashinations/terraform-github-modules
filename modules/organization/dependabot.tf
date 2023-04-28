resource "github_dependabot_organization_secret" "identified_by" {
  depends_on = [github_organization_settings.this]
  for_each   = var.dependabot.secrets

  secret_name = each.key

  encrypted_value         = each.value.value_type == "encrypted" ? each.value.value : null
  plaintext_value         = each.value.value_type == "plaintext" ? each.value.value : null
  selected_repository_ids = each.value.repository_ids
  visibility              = each.value.visibility
}
