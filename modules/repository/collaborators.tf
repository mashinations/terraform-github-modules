locals {
  _builtin_collaborator_roles = ["admin", "maintain", "push", "triage", "pull"]

  ## Ensure that, if a team or user is defined in more than one role-group, they
  ## are assigned the role granting the least permissions.
  collaborator_roles = distinct(concat(
    local._builtin_collaborator_roles,
    tolist(setsubtract(keys(var.collaborators.teams), local._builtin_collaborator_roles)),
    tolist(setsubtract(keys(var.collaborators.users), local._builtin_collaborator_roles)),
  ))
  collaborating_teams = merge([
    for role in local.collaborator_roles : merge(
      { for i in lookup(var.collaborators.teams, role, []) : replace(lower(i), "/[^a-z0-9_]/", "-") => role },
    )
  ]...)
  collaborating_users = merge([
    for role in local.collaborator_roles : merge(
      { for i in lookup(var.collaborators.users, role, []) : replace(lower(i), "/[^a-z0-9_]/", "-") => role },
    )
  ]...)
}

resource "github_repository_collaborators" "this" {
  repository = github_repository.this.name

  dynamic "team" {
    for_each = local.collaborating_teams
    content {
      permission = team.value
      team_id    = team.key
    }
  }
  dynamic "user" {
    for_each = local.collaborating_users
    content {
      permission = user.value
      username   = user.key
    }
  }
}
