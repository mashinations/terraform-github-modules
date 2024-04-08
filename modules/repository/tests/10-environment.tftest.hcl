run "_setup_" {
  command = apply
  module { source = "./tests/setup" }
  variables { test_suite = "environment" }
}

## ============================================================================================== ##
##                            Test - Default Values for Actions Feature                           ##
## ============================================================================================== ##
run "check_defaults" {
  command = apply
  variables {
    name     = run._setup_.repository_name
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.environments
    condition     = length(output.environments) == 0
    error_message = "Default value for 'environments' should be empty"
  }

  assert { ## output.environment_secrets
    condition     = length(output.environment_secrets) == 0
    error_message = "Default value for 'environment_secrets' should be empty"
  }

  assert { ## output.environment_variables
    condition     = length(output.environment_variables) == 0
    error_message = "Default value for 'environment_variables' should be empty"
  }
}

## ============================================================================================== ##
##                              Test - Feature Configuration Enabled                              ##
## ============================================================================================== ##
run "check_feature_environments" {
  command = apply
  variables {
    name = run._setup_.repository_name
    environments = {
      dev = {}
    }
    // settings = { visibility = "public" }
    settings = { archive_on_destroy = run._setup_.archive_repository, visibility = "public" }
  }

  assert { ## output.environments
    condition     = length(output.environments) == 1
    error_message = "Value for 'environments' should have 1 item"
  }
  assert { ## output.environments["dev"]
    condition     = output.environments["dev"] != null
    error_message = "Value for 'environments[\"dev\"]' should not be null"
  }
  assert { ## output.environments["dev"].can_admins_bypass
    condition     = output.environments["dev"].can_admins_bypass == false
    error_message = "Value for 'environments[\"dev\"].can_admins_bypass' should be false"
  }
  assert { ## output.environments["dev"].environment
    condition     = output.environments["dev"].environment == "dev"
    error_message = "Value for 'environments[\"dev\"].environment' should be 'dev'"
  }
  assert { ## output.environments["dev"].prevent_self_review
    condition     = output.environments["dev"].prevent_self_review == true
    error_message = "Value for 'environments[\"dev\"].prevent_self_review' should be true"
  }
  assert { ## output.environments["dev"].repository
    condition     = output.environments["dev"].repository == run._setup_.repository_name
    error_message = "Value for 'environments[\"dev\"].repository' should be equal to the repository name"
  }
  assert { ## output.environments["dev"].wait_timer
    condition     = output.environments["dev"].wait_timer == 0
    error_message = "Value for 'environments[\"dev\"].wait_timer' should be 0"
  }

  assert { ## output.environments["dev"].deployment_branch_policy
    condition     = length(output.environments["dev"].deployment_branch_policy) == 1
    error_message = "Value for 'environments[\"dev\"].deployment_branch_policy' should have 1 item"
  }
  assert { ## output.environments["dev"].deployment_branch_policy[0].custom_branch_policies
    condition     = output.environments["dev"].deployment_branch_policy[0].custom_branch_policies == false
    error_message = "Value for 'environments[\"dev\"].deployment_branch_policy[0].custom_branch_policies' should be false"
  }
  assert { ## output.environments["dev"].deployment_branch_policy[0].protected_branches
    condition     = output.environments["dev"].deployment_branch_policy[0].protected_branches == true
    error_message = "Value for 'environments[\"dev\"].deployment_branch_policy[0].protected_branches' should be true"
  }

  assert { ## output.environments["dev"].reviewers[0].teams
    condition     = output.environments["dev"].reviewers[0].teams == null
    error_message = "Value for 'environments[\"dev\"].reviewers[0].teams' should be 'null'"
  }
  assert { ## output.environments["dev"].reviewers[0].users
    condition     = output.environments["dev"].reviewers[0].users == null
    error_message = "Value for 'environments[\"dev\"].reviewers[0].users' should be 'null'"
  }

  assert { ## output.environment_secrets
    condition     = length(output.environment_secrets) == 0
    error_message = "Default value for 'environment_secrets' should be empty"
  }

  assert { ## output.environment_variables
    condition     = length(output.environment_variables) == 0
    error_message = "Default value for 'environment_variables' should be empty"
  }
}

## ============================================================================================== ##
##                         Test - Feature Configuration Enabled - Secrets                         ##
## ============================================================================================== ##
run "check_feature_enabled_secrets" {
  command = apply
  variables {
    name = run._setup_.repository_name
    environments = {
      dev = {
        secrets = {
          EXAMPLE_SECRET_ENCRYPTED = { value = "lLYvhF5ho2i2x5U16fI3Z2Y9raEbXD0yFn09IDUQX1bXrHAbi/gJYpq833H4k1+Xm9/rH2o2/y3Lcmm6ekA8TeHVqbKwWZw=" }
          EXAMPLE_SECRET_PLAINTEXT = { value = "EXAMPLE_VALUE_PLAINTEXT", value_type = "plaintext" }
        }
      }
    }
    // settings = { visibility = "public" }
    settings = { archive_on_destroy = run._setup_.archive_repository, visibility = "public" }
  }

  assert { ## output.environment_secrets["dev:EXAMPLE_SECRET_ENCRYPTED"]
    condition     = output.environment_secrets["dev:EXAMPLE_SECRET_ENCRYPTED"] != null
    error_message = "Value for 'environment_secrets[\"dev:EXAMPLE_SECRET_ENCRYPTED\"]' should not be null"
  }
  assert { ## output.environment_secrets["dev:EXAMPLE_SECRET_ENCRYPTED"].environment
    condition     = output.environment_secrets["dev:EXAMPLE_SECRET_ENCRYPTED"].environment == "dev"
    error_message = "Value for 'environment_secrets[\"dev:EXAMPLE_SECRET_ENCRYPTED\"].environment' should be 'dev'"
  }
  assert { ## ## output.environment_secrets["dev:EXAMPLE_SECRET_ENCRYPTED"].repository
    condition     = output.environment_secrets["dev:EXAMPLE_SECRET_ENCRYPTED"].repository == run._setup_.repository_name
    error_message = "Value for 'environment_secrets[\"dev:EXAMPLE_SECRET_ENCRYPTED\"].repository' should be equal to the repository name"
  }

  assert { ## output.environment_secrets["dev:EXAMPLE_SECRET_PLAINTEXT"]
    condition     = output.environment_secrets["dev:EXAMPLE_SECRET_PLAINTEXT"] != null
    error_message = "Value for 'environment_secrets[\"dev:EXAMPLE_SECRET_PLAINTEXT\"]' should not be null"
  }
  assert { ## output.environment_secrets["dev:EXAMPLE_SECRET_PLAINTEXT"].environment
    condition     = output.environment_secrets["dev:EXAMPLE_SECRET_PLAINTEXT"].environment == "dev"
    error_message = "Value for 'environment_secrets[\"dev:EXAMPLE_SECRET_PLAINTEXT\"].environment' should be 'dev'"
  }
  assert { ## ## output.environment_secrets["dev:EXAMPLE_SECRET_PLAINTEXT"].repository
    condition     = output.environment_secrets["dev:EXAMPLE_SECRET_PLAINTEXT"].repository == run._setup_.repository_name
    error_message = "Value for 'environment_secrets[\"dev:EXAMPLE_SECRET_PLAINTEXT\"].repository' should be equal to the repository name"
  }
}

## ============================================================================================== ##
##                        Test - Feature Configuration Enabled - Variables                        ##
## ============================================================================================== ##
run "check_feature_enabled_variables" {
  command = apply
  variables {
    name = run._setup_.repository_name
    environments = {
      dev = {
        variables = {
          EXAMPLE_VARIABLE = { value = "EXAMPLE_VALUE" }
        }
      }
    }
    // settings = { visibility = "public" }
    settings = { archive_on_destroy = run._setup_.archive_repository, visibility = "public" }
  }

  assert { ## output.environment_variables["dev:EXAMPLE_VARIABLE"]
    condition     = output.environment_variables["dev:EXAMPLE_VARIABLE"] != null
    error_message = "Value for 'environment_variables[\"dev:EXAMPLE_VARIABLE\"]' should not be null"
  }
  assert { ## output.environment_variables["dev:EXAMPLE_VARIABLE"].environment
    condition     = output.environment_variables["dev:EXAMPLE_VARIABLE"].environment == "dev"
    error_message = "Value for 'environment_variables[\"dev:EXAMPLE_VARIABLE\"].environment' should be 'dev'"
  }
  assert { ## ## output.environment_variables["dev:EXAMPLE_VARIABLE"].repository
    condition     = output.environment_variables["dev:EXAMPLE_VARIABLE"].repository == run._setup_.repository_name
    error_message = "Value for 'environment_variables[\"dev:EXAMPLE_VARIABLE\"].repository' should be equal to the repository name"
  }
  assert { ## output.environment_variables["dev:EXAMPLE_VARIABLE"].value
    condition     = output.environment_variables["dev:EXAMPLE_VARIABLE"].value == "EXAMPLE_VALUE"
    error_message = "Value for 'environment_variables[\"dev:EXAMPLE_VARIABLE\"].value' should be 'EXAMPLE_VALUE'"
  }
}
