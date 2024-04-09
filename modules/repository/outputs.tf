output "actions_permissions" {
  description = "The current permissions for Actions"
  value       = github_actions_repository_permissions.this
}
output "actions_secrets" {
  description = "A map of Actions secret objects keyed by secret name"
  sensitive   = true
  value       = github_actions_secret.identified_by
}
output "actions_variables" {
  description = "A map of Actions variable objects keyed by variable name"
  value       = github_actions_variable.identified_by
}

output "branches" {
  description = "A map of branch objects keyed by branch name"
  value       = github_branch.identified_by
}
output "branch_default" {
  description = "The default branch object"
  value       = one(github_branch_default.this)
}
output "branch_protections" {
  description = "A map of branch protection objects keyed by pattern"
  value       = github_branch_protection.for_pattern
}

output "collaborators" {
  description = "The collaborators object listing teams and users with access"
  value       = github_repository_collaborators.this
}

output "dependabot_secrets" {
  description = "A map of Dependabot secret objects keyed by secret name"
  sensitive   = true
  value       = github_dependabot_secret.identified_by
}

output "environments" {
  description = "A map of environment objects keyed by environment name"
  value       = github_repository_environment.identified_by
}
output "environment_secrets" {
  description = "A map of environment secret objects keyed by environment name and secret name"
  sensitive   = true
  value       = github_actions_environment_secret.identified_by
}
output "environment_variables" {
  description = "A map of environment variable objects keyed by environment name and variable name"
  value       = github_actions_environment_variable.identified_by
}

output "settings" {
  description = "The current settings for the repository"
  value       = github_repository.this
}
