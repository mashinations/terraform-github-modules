output "test_date" {
  description = "The date calculated for this test run"
  value       = local.date
}
output "test_id" {
  description = "The ID calculated for this test run"
  value       = random_string.id.result
}

## Convenient outputs calculated using the values above
output "archive_repository" {
  description = "A flag for whether or not to archive or delete the repository"
  value       = false
}
output "repository_name" {
  description = "A name suitable for use as the repository name"
  value       = "${var.test_suite}-${local.date}-${random_string.id.result}"
}
