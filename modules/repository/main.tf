resource "github_repository" "this" {
  name = var.name

  archived           = var.settings.archived
  auto_init          = var.settings.auto_init
  description        = var.settings.description
  gitignore_template = var.settings.gitignore_template
  homepage_url       = var.settings.homepage_url
  is_template        = var.settings.is_template
  license_template   = var.settings.license_template
  topics             = var.settings.topics
  visibility         = var.settings.visibility

  dynamic "template" {
    for_each = var.settings.template != null ? [var.settings.template] : []

    content {
      owner      = template.value.owner
      repository = template.value.repository
    }
  }

  ## Feature Configuration
  has_discussions = var.settings.has_discussions
  has_issues      = var.settings.has_issues
  has_projects    = var.settings.has_projects
  has_wiki        = var.settings.has_wiki

  dynamic "pages" {
    for_each = var.settings.pages != null ? [var.settings.pages] : []

    content {
      source {
        branch = pages.value.source.branch
        path   = pages.value.source.path
      }
      cname = try(pages.value.cname, null)
    }
  }

  ## Policy Configuration
  allow_auto_merge            = var.settings.allow_auto_merge
  allow_merge_commit          = var.settings.allow_merge_commit
  allow_rebase_merge          = var.settings.allow_rebase_merge
  allow_squash_merge          = var.settings.allow_squash_merge
  allow_update_branch         = var.settings.allow_update_branch
  archive_on_destroy          = var.settings.archive_on_destroy
  delete_branch_on_merge      = var.settings.delete_branch_on_merge
  merge_commit_message        = var.settings.allow_merge_commit ? var.settings.merge_commit_message : null
  merge_commit_title          = var.settings.allow_merge_commit ? var.settings.merge_commit_title : null
  squash_merge_commit_message = var.settings.allow_squash_merge ? var.settings.squash_merge_commit_message : null
  squash_merge_commit_title   = var.settings.allow_squash_merge ? var.settings.squash_merge_commit_title : null
  vulnerability_alerts        = var.settings.vulnerability_alerts
  web_commit_signoff_required = var.settings.web_commit_signoff_required

  lifecycle {
    ignore_changes = [
      ## Settings maintained by users and may change after creation
      description, homepage_url, topics,

      ## Settings valid only when the repository is created and can
      ## not be changed afterwards
      auto_init, gitignore_template, license_template, template,
    ]
  }
}
