resource "github_actions_organization_secret" "identified_by" {
  for_each = var.actions_secrets != null ? var.actions_secrets : {}

  secret_name = each.key

  encrypted_value         = each.value.encrypted_value
  selected_repository_ids = each.value.repository_ids
  visibility              = each.value.visibility
}
