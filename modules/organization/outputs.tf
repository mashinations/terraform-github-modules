output "actions_permnissions" {
  description = "The current permissions for Actions"
  value       = github_actions_organization_permissions.this
}
output "actions_secrets" {
  description = "A map of Actions secret objects keyed by secret name"
  sensitive   = true
  value       = github_actions_organization_secret.identified_by
}
output "actions_variables" {
  description = "A map of Actions variable objects keyed by variable name"
  value       = github_actions_organization_variable.identified_by
}

output "admins" {
  description = "A map of users added to the organization with the `admin` role"
  value       = github_membership.admins
}
output "admins_team" {
  description = "The team created for admins, if requested"
  value       = try(github_team.admins[0], {})
}

output "blocked_users" {
  description = "A map of users blocked from the organization"
  value       = github_organization_block.user
}

output "dependabot_secrets" {
  description = "A map of Dependabot secret objects keyed by secret name"
  sensitive   = true
  value       = github_dependabot_organization_secret.identified_by
}

output "members" {
  description = "A map of users added to the organization with the `member` role"
  value       = github_membership.members
}
output "members_team" {
  description = "The team created for members, if requested"
  value       = try(github_team.members[0], {})
}

output "security_managers" {
  description = "A map of users added to the organization with the `security manager` role"
  value       = github_membership.security_managers
}
output "security_managers_team" {
  description = "The team created for security managers, if requested"
  value       = try(github_team.security_managers[0], {})
}

output "settings" {
  description = "A map of the organization settings for reference"
  value       = github_organization_settings.this
}
