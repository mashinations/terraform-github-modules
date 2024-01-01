resource "github_organization_block" "user" {
  for_each = var.blocked_users
  username = each.key
}

## ========================================================================== ##
## Organization Membership and Team Management - Admins                       ##
## ========================================================================== ##
data "github_users" "admins" {
  usernames = var.admins
}

resource "github_membership" "admins" {
  for_each = toset(data.github_users.admins.logins)

  role     = "admin"
  username = each.key

  lifecycle {
    precondition {
      condition     = contains(keys(github_organization_block.user), each.key) != true
      error_message = "Error: Blocked user '${each.key}' cannot be an admin"
    }
  }
}

resource "github_team" "admins" {
  count = var.admins_team != null ? 1 : 0

  description = var.admins_team.description
  name        = var.admins_team.name
  privacy     = var.admins_team.privacy
}

resource "github_team_members" "admins" {
  count = var.admins_team != null && length(github_membership.admins) > 0 ? 1 : 0

  team_id = github_team.admins[0].id

  dynamic "members" {
    for_each = github_membership.admins
    content {
      role     = "maintainer"
      username = members.value.username
    }
  }
}

## ========================================================================== ##
## Organization Membership and Team Management - Members                      ##
## ========================================================================== ##
data "github_users" "members" {
  usernames = var.members
}

resource "github_membership" "members" {
  for_each = toset(data.github_users.members.logins)

  role     = "member"
  username = each.key

  lifecycle {
    precondition {
      condition     = contains(keys(github_membership.admins), each.key) != true
      error_message = "Error: Admin user '${each.key}' cannot be a member"
    }
    precondition {
      condition     = contains(keys(github_organization_block.user), each.key) != true
      error_message = "Error: Blocked user '${each.key}' cannot be a member"
    }
  }
}

resource "github_team" "members" {
  count = var.members_team != null ? 1 : 0

  description = var.members_team.description
  name        = var.members_team.name
  privacy     = var.members_team.privacy
}

resource "github_team_members" "members" {
  count = var.members_team != null && length(github_membership.members) > 0 ? 1 : 0

  team_id = github_team.members[0].id

  dynamic "members" {
    for_each = github_membership.members
    content {
      role     = "member"
      username = members.value.username
    }
  }
}

## ========================================================================== ##
## Organization Membership and Team Management - Security Managers            ##
## ========================================================================== ##
data "github_users" "security_managers" {
  usernames = var.security_managers
}

resource "github_membership" "security_managers" {
  for_each = toset(data.github_users.security_managers.logins)

  role     = "member"
  username = each.key

  lifecycle {
    precondition {
      condition     = contains(keys(github_membership.admins), each.key) != true
      error_message = "Error: Admin user '${each.key}' cannot be a security manager"
    }
    precondition {
      condition     = contains(keys(github_membership.members), each.key) != true
      error_message = "Error: Member user '${each.key}' cannot be a security manager"
    }
    precondition {
      condition     = contains(keys(github_organization_block.user), each.key) != true
      error_message = "Error: Blocked user '${each.key}' cannot be a security manager"
    }
  }
}

resource "github_team" "security_managers" {
  count = var.security_managers_team != null ? 1 : 0

  description = var.security_managers_team.description
  name        = var.security_managers_team.name
  privacy     = var.security_managers_team.privacy
}

resource "github_team_members" "security_managers" {
  count = var.security_managers_team != null && length(github_membership.security_managers) > 0 ? 1 : 0

  team_id = github_team.security_managers[0].id

  dynamic "members" {
    for_each = github_membership.security_managers
    content {
      role     = "member"
      username = members.value.username
    }
  }
}

resource "github_organization_security_manager" "this" {
  count = var.security_managers_team != null ? 1 : 0

  team_slug = github_team.security_managers[0].slug
}
