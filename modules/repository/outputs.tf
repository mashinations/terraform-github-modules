output "branch_protections" {
  description = "A map of the branch protections"
  value       = github_branch_protection.for_pattern
}

output "environments" {
  description = "A map of the environments"
  value       = github_repository_environment.identified_by
}

output "settings" {
  description = "A map of the repository settings"
  value       = github_repository.this
}
