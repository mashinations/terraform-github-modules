resource "github_organization_settings" "this" {
  billing_email = var.billing_email

  ## Company/Profile Details
  blog             = var.settings.blog
  company          = var.settings.company
  description      = var.settings.description
  email            = var.settings.email
  location         = var.settings.location
  name             = var.settings.name
  twitter_username = var.settings.twitter_username

  ## GitHub Settings
  default_repository_permission                            = var.settings.default_repository_permission
  dependabot_alerts_enabled_for_new_repositories           = var.settings.dependabot_alerts_enabled
  dependabot_security_updates_enabled_for_new_repositories = var.settings.dependabot_security_updates_enabled
  dependency_graph_enabled_for_new_repositories            = var.settings.dependency_graph_enabled
  has_organization_projects                                = var.settings.has_organization_projects
  has_repository_projects                                  = var.settings.has_repository_projects
  members_can_create_pages                                 = var.settings.members_can_create_pages
  members_can_create_private_pages                         = var.settings.members_can_create_private_pages
  members_can_create_private_repositories                  = var.settings.members_can_create_private_repositories
  members_can_create_public_pages                          = var.settings.members_can_create_public_pages
  members_can_create_public_repositories                   = var.settings.members_can_create_public_repositories
  members_can_create_repositories                          = var.settings.members_can_create_repositories
  members_can_fork_private_repositories                    = var.settings.members_can_fork_private_repositories
  secret_scanning_enabled_for_new_repositories             = var.settings.secret_scanning_enabled
  web_commit_signoff_required                              = var.settings.web_commit_signoff_required

  ## GitHub Enterprise Settings
  advanced_security_enabled_for_new_repositories               = var.settings.advanced_security_enabled
  members_can_create_internal_repositories                     = var.settings.members_can_create_internal_repositories
  secret_scanning_push_protection_enabled_for_new_repositories = var.settings.secret_scanning_push_protection_enabled
}
