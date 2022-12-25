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

output "settings" {
  description = "A map of the organization settings for reference"
  value       = github_organization_settings.this
}
