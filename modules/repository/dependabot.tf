resource "github_dependabot_secret" "identified_by" {
  depends_on = [github_repository.this]
  for_each   = var.dependabot.secrets

  repository  = github_repository.this.name
  secret_name = each.key

  encrypted_value = each.value.value_type == "encrypted" ? each.value.value : null
  plaintext_value = each.value.value_type == "plaintext" ? each.value.value : null
}
