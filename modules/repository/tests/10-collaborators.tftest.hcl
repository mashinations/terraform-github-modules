run "_setup_" {
  command = apply
  module { source = "./tests/setup" }
  variables { test_suite = "collaborators" }
}

## ============================================================================================== ##
##                         Test - Default Values for Collaborators Feature                        ##
## ============================================================================================== ##
run "check_defaults" {
  command = apply
  variables {
    name     = run._setup_.repository_name
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.collaborators.id
    condition     = output.collaborators.id == run._setup_.repository_name
    error_message = "Default value for 'collaborators.id' should be '${run._setup_.repository_name}'"
  }
  assert { ## output.collaborators.invitation_ids
    condition     = length(output.collaborators.invitation_ids) == 0
    error_message = "Default value for 'collaborators.invitation_ids' should be empty"
  }
  assert { ## output.collaborators.repository == run._setup_.repository_name
    condition     = output.collaborators.repository == run._setup_.repository_name
    error_message = "Default value forß 'collaborators.repository' should be '${run._setup_.repository_name}'"
  }
  assert { ## output.collaborators.team
    condition     = length(output.collaborators.team) == 0
    error_message = "Default value for 'collaborators.team' should be empty"
  }
  assert { ## output.collaborators.user
    condition     = length(output.collaborators.user) == 0
    error_message = "Default value for 'collaborators.user' should be empty"
  }
}

## ============================================================================================== ##
##                        Test - Feature Configuration - Admin Permissions                        ##
## ============================================================================================== ##
run "check_feature_admins" {
  command = apply
  variables {
    name = run._setup_.repository_name
    collaborators = {
      teams = {
        admin = ["admins"]
      }
      users = {
        admin = ["mashinations-admin"]
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team) != null
    error_message = "Value for 'collaborators.team' should not be 'null'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).team_id == "admins"
    error_message = "Value for 'collaborators.team.team_id' should be 'admins'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).permission == "admin"
    error_message = "Value for 'collaborators.team.permission' should be 'admin'"
  }

  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user) != null
    error_message = "Value for 'collaborators.user' should not be 'null'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).username == "mashinations-admin"
    error_message = "Value for 'collaborators.user.username' should be 'mashinations-admin'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).permission == "admin"
    error_message = "Value for 'collaborators.user.permission' should be 'admin'"
  }
}

## ============================================================================================== ##
##                       Test - Feature Configuration - Maintain Permissions                      ##
## ============================================================================================== ##
run "check_feature_maintainers" {
  command = apply
  variables {
    name = run._setup_.repository_name
    collaborators = {
      teams = {
        maintain = ["maintainers"]
      }
      users = {
        maintain = ["mashinations-user"]
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team) != null
    error_message = "Value for 'collaborators.team' should not be 'null'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).team_id == "maintainers"
    error_message = "Value for 'collaborators.team.team_id' should be 'maintainers'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).permission == "maintain"
    error_message = "Value for 'collaborators.team.permission' should be 'maintain'"
  }

  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user) != null
    error_message = "Value for 'collaborators.user' should not be 'null'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).username == "mashinations-user"
    error_message = "Value for 'collaborators.user.username' should be 'mashinations-user'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).permission == "maintain"
    error_message = "Value for 'collaborators.user.permission' should be 'maintain'"
  }
}
run "check_feature_maintainers_least_privilege" {
  command = apply
  variables {
    name = run._setup_.repository_name
    collaborators = {
      teams = {
        admin    = ["maintainers"]
        maintain = ["maintainers"]
      }
      users = {
        admin    = ["mashinations-flex"]
        maintain = ["mashinations-flex"]
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team) != null
    error_message = "Value for 'collaborators.team' should not be 'null'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).team_id == "maintainers"
    error_message = "Value for 'collaborators.team.team_id' should be 'maintainers'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).permission == "maintain"
    error_message = "Value for 'collaborators.team.permission' should be 'maintain'"
  }

  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user) != null
    error_message = "Value for 'collaborators.user' should not be 'null'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).username == "mashinations-flex"
    error_message = "Value for 'collaborators.user.username' should be 'mashinations-flex'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).permission == "maintain"
    error_message = "Value for 'collaborators.user.permission' should be 'maintain'"
  }
}

## ============================================================================================== ##
##                         Test - Feature Configuration - Pull Permissions                        ##
## ============================================================================================== ##
run "check_feature_pullers" {
  command = apply
  variables {
    name = run._setup_.repository_name
    collaborators = {
      teams = {
        pull = ["pullers"]
      }
      users = {
        pull = ["mashinations-user"]
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team) != null
    error_message = "Value for 'collaborators.team' should not be 'null'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).team_id == "pullers"
    error_message = "Value for 'collaborators.team.team_id' should be 'pullers'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).permission == "pull"
    error_message = "Value for 'collaborators.team.permission' should be 'pull'"
  }

  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user) != null
    error_message = "Value for 'collaborators.user' should not be 'null'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).username == "mashinations-user"
    error_message = "Value for 'collaborators.user.username' should be 'mashinations-user'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).permission == "pull"
    error_message = "Value for 'collaborators.user.permission' should be 'pull'"
  }
}
run "check_feature_pullers_least_privilege" {
  command = apply
  variables {
    name = run._setup_.repository_name
    collaborators = {
      teams = {
        pull   = ["pullers"]
        triage = ["pullers"]
      }
      users = {
        pull   = ["mashinations-flex"]
        triage = ["mashinations-flex"]
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team) != null
    error_message = "Value for 'collaborators.team' should not be 'null'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).team_id == "pullers"
    error_message = "Value for 'collaborators.team.team_id' should be 'pullers'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).permission == "pull"
    error_message = "Value for 'collaborators.team.permission' should be 'pull'"
  }

  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user) != null
    error_message = "Value for 'collaborators.user' should not be 'null'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).username == "mashinations-flex"
    error_message = "Value for 'collaborators.user.username' should be 'mashinations-flex'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).permission == "pull"
    error_message = "Value for 'collaborators.user.permission' should be 'pull'"
  }
}

## ============================================================================================== ##
##                         Test - Feature Configuration - Push Permissions                        ##
## ============================================================================================== ##
run "check_feature_pushers" {
  command = apply
  variables {
    name = run._setup_.repository_name
    collaborators = {
      teams = {
        push = ["pushers"]
      }
      users = {
        push = ["mashinations-user"]
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team) != null
    error_message = "Value for 'collaborators.team' should not be 'null'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).team_id == "pushers"
    error_message = "Value for 'collaborators.team.team_id' should be 'pushers'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).permission == "push"
    error_message = "Value for 'collaborators.team.permission' should be 'push'"
  }

  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user) != null
    error_message = "Value for 'collaborators.user' should not be 'null'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).username == "mashinations-user"
    error_message = "Value for 'collaborators.user.username' should be 'mashinations-user'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).permission == "push"
    error_message = "Value for 'collaborators.user.permission' should be 'push'"
  }
}
run "check_feature_pushers_least_privilege" {
  command = apply
  variables {
    name = run._setup_.repository_name
    collaborators = {
      teams = {
        maintain = ["pushers"]
        push     = ["pushers"]
      }
      users = {
        maintain = ["mashinations-flex"]
        push     = ["mashinations-flex"]
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team) != null
    error_message = "Value for 'collaborators.team' should not be 'null'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).team_id == "pushers"
    error_message = "Value for 'collaborators.team.team_id' should be 'pushers'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).permission == "push"
    error_message = "Value for 'collaborators.team.permission' should be 'push'"
  }

  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user) != null
    error_message = "Value for 'collaborators.user' should not be 'null'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).username == "mashinations-flex"
    error_message = "Value for 'collaborators.user.username' should be 'mashinations-flex'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).permission == "push"
    error_message = "Value for 'collaborators.user.permission' should be 'push'"
  }
}

## ============================================================================================== ##
##                        Test - Feature Configuration - Triage Permissions                       ##
## ============================================================================================== ##
run "check_feature_triagers" {
  command = apply
  variables {
    name = run._setup_.repository_name
    collaborators = {
      teams = {
        triage = ["triagers"]
      }
      users = {
        triage = ["mashinations-user"]
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team) != null
    error_message = "Value for 'collaborators.team' should not be 'null'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).team_id == "triagers"
    error_message = "Value for 'collaborators.team.team_id' should be 'triagers'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).permission == "triage"
    error_message = "Value for 'collaborators.team.permission' should be 'triage'"
  }

  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user) != null
    error_message = "Value for 'collaborators.user' should not be 'null'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).username == "mashinations-user"
    error_message = "Value for 'collaborators.user.username' should be 'mashinations-user'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).permission == "triage"
    error_message = "Value for 'collaborators.user.permission' should be 'triage'"
  }
}
run "check_feature_triagers_least_privilege" {
  command = apply
  variables {
    name = run._setup_.repository_name
    collaborators = {
      teams = {
        push   = ["triagers"]
        triage = ["triagers"]
      }
      users = {
        push   = ["mashinations-flex"]
        triage = ["mashinations-flex"]
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team) != null
    error_message = "Value for 'collaborators.team' should not be 'null'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).team_id == "triagers"
    error_message = "Value for 'collaborators.team.team_id' should be 'triagers'"
  }
  assert { ## output.collaborators.team
    condition     = one(output.collaborators.team).permission == "triage"
    error_message = "Value for 'collaborators.team.permission' should be 'triage'"
  }

  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user) != null
    error_message = "Value for 'collaborators.user' should not be 'null'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).username == "mashinations-flex"
    error_message = "Value for 'collaborators.user.username' should be 'mashinations-flex'"
  }
  assert { ## output.collaborators.user
    condition     = one(output.collaborators.user).permission == "triage"
    error_message = "Value for 'collaborators.user.permission' should be 'triage'"
  }
}
