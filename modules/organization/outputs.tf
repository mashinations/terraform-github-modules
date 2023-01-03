output "admins" {
  description = "A map of users added to the organization with the `admin` role"
  value       = github_membership.admins
}
output "admins_team" {
  description = "The team created for admins, if requested"
  value       = try(github_team.admins[0], {})
}

output "members" {
  description = "A map of users added to the organization with the `member` role"
  value       = github_membership.members
}
output "members_team" {
  description = "The team created for members, if requested"
  value       = try(github_team.members[0], {})
}

output "actions_secrets" {
  description = "A map of the organization's actions secrets"
  sensitive   = true
  value       = github_actions_organization_secret.identified_by
}
output "dependabot_secrets" {
  description = "A map of the organization's dependabot secrets"
  sensitive   = true
  value       = github_dependabot_organization_secret.identified_by
}

output "settings" {
  description = "A map of the organization settings for reference"
  value       = github_organization_settings.this
}
