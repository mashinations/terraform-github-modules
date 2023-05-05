output "branch_protections" {
  description = "A map of branch protection objects keyed by pattern"
  value       = github_branch_protection.for_pattern
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
