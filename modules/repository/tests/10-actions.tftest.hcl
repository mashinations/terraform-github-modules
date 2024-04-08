run "_setup_" {
  command = apply
  module { source = "./tests/setup" }
  variables { test_suite = "actions" }
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

  assert { ## output.actions_permissions.enabled
    condition     = output.actions_permissions.enabled == true
    error_message = "Default value for 'enabled' should be 'true'"
  }

  assert { ## output.actions_permissions.allowed_actions
    condition     = output.actions_permissions.allowed_actions == "all"
    error_message = "Default value for 'allowed_actions' should be 'all'"
  }
  assert { ## output.actions_permissions.allowed_actions_config
    condition     = length(output.actions_permissions.allowed_actions_config) == 0
    error_message = "Default value for 'allowed_actions_config' should be empty"
  }
  assert { ## output.actions_permissions.repository
    condition     = output.actions_permissions.repository == run._setup_.repository_name
    error_message = "Default value for 'repository' should be '${run._setup_.repository_name}'"
  }
  assert { ## output.actions_secrets
    condition     = length(output.actions_secrets) == 0
    error_message = "Default value for 'actions_secrets' should be empty"
  }
  assert { ## output.actions_variables
    condition     = length(output.actions_variables) == 0
    error_message = "Default value for 'actions_variables' should be empty"
  }
}

## ============================================================================================== ##
##                              Test - Feature Configuration Disabled                             ##
## ============================================================================================== ##
run "check_feature_disabled" {
  command = apply
  variables {
    name     = run._setup_.repository_name
    actions  = { enabled = false }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.actions_permissions.enabled
    condition     = output.actions_permissions.enabled == false
    error_message = "Value for 'enabled' should be 'false'"
  }

  assert { ## output.actions_permissions.allowed_actions
    condition     = output.actions_permissions.allowed_actions == "all"
    error_message = "Value for 'allowed_actions' should be 'all'"
  }
  assert { ## output.actions_permissions.allowed_actions_config
    condition     = length(output.actions_permissions.allowed_actions_config) == 0
    error_message = "Value for 'allowed_actions_config' should be empty"
  }
  assert { ## output.actions_permissions.repository
    condition     = output.actions_permissions.repository == run._setup_.repository_name
    error_message = "Value for 'repository' should be '${run._setup_.repository_name}'"
  }
  assert { ## output.actions_secrets
    condition     = length(output.actions_secrets) == 0
    error_message = "Value for 'actions_secrets' should be empty"
  }
  assert { ## output.actions_variables
    condition     = length(output.actions_variables) == 0
    error_message = "Value for 'actions_variables' should be empty"
  }
}

## ============================================================================================== ##
##                              Test - Feature Configuration Enabled                              ##
## ============================================================================================== ##
run "check_feature_enabled" {
  command = apply
  variables {
    name = run._setup_.repository_name
    actions = {
      allowed_actions = "selected"
      allowed_actions_config = {
        github_owned_allowed = true
        verified_allowed     = true
      }
      enabled = true
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.actions_permissions.allowed_actions
    condition     = output.actions_permissions.enabled == true
    error_message = "Value for 'allowed_actions.enabled' should be 'true'"
  }

  assert { ## output.actions_permissions.allowed_actions
    condition     = output.actions_permissions.allowed_actions == "selected"
    error_message = "Value for 'allowed_actions' should be 'selected'"
  }
  assert { ## output.actions_permissions.allowed_actions_config[0]
    condition     = element(output.actions_permissions.allowed_actions_config, 0) != null
    error_message = "Value for element 0 of 'allowed_actions_config' should not be 'null'"
  }
  assert { ## output.actions_permissions.allowed_actions_config[0].github_owned_allowed
    condition     = output.actions_permissions.allowed_actions_config[0].github_owned_allowed == true
    error_message = "Value for 'allowed_actions_config[0].github_owned_allowed' should be 'true'"
  }
  assert { ## output.actions_permissions.allowed_actions_config[0].verified_allowed
    condition     = output.actions_permissions.allowed_actions_config[0].verified_allowed == true
    error_message = "Value for 'allowed_actions_config[0].verified_allowed' should be 'true'"
  }
  assert { ## output.actions_permissions.repository
    condition     = output.actions_permissions.repository == run._setup_.repository_name
    error_message = "Value for 'repository' should be '${run._setup_.repository_name}'"
  }
}

## ============================================================================================== ##
##                         Test - Feature Configuration Enabled - Secrets                         ##
## ============================================================================================== ##
run "check_feature_enabled_secrets" {
  command = apply
  variables {
    name = run._setup_.repository_name
    actions = {
      enabled = true
      secrets = {
        EXAMPLE_SECRET_ENCRYPTED = { value = "lLYvhF5ho2i2x5U16fI3Z2Y9raEbXD0yFn09IDUQX1bXrHAbi/gJYpq833H4k1+Xm9/rH2o2/y3Lcmm6ekA8TeHVqbKwWZw=" }
        EXAMPLE_SECRET_PLAINTEXT = { value = "EXAMPLE_VALUE_PLAINTEXT", value_type = "plaintext" }
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.actions_secrets["EXAMPLE_SECRET_ENCRYPTED"]
    condition     = output.actions_secrets["EXAMPLE_SECRET_ENCRYPTED"] != null
    error_message = "Value for 'actions_secrets[\"EXAMPLE_SECRET_ENCRYPTED\"]' should not be null"
  }
  assert { ## output.actions_secrets["EXAMPLE_SECRET_PLAINTEXT"]
    condition     = output.actions_secrets["EXAMPLE_SECRET_PLAINTEXT"] != null
    error_message = "Value for 'actions_secrets[\"EXAMPLE_SECRET_PLAINTEXT\"]' should not be null"
  }
}

## ============================================================================================== ##
##                        Test - Feature Configuration Enabled - Variables                        ##
## ============================================================================================== ##
run "check_feature_enabled_variables" {
  command = apply
  variables {
    name = run._setup_.repository_name
    actions = {
      enabled = true
      variables = {
        EXAMPLE_VARIABLE = { value = "EXAMPLE_VALUE" }
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.actions_variables["EXAMPLE_VARIABLE"]
    condition     = output.actions_variables["EXAMPLE_VARIABLE"] != null
    error_message = "Value for 'actions_variables[\"EXAMPLE_VARIABLE\"]' should not be null"
  }
  assert { ## output.actions_variables["EXAMPLE_VARIABLE"].value
    condition     = output.actions_variables["EXAMPLE_VARIABLE"].value == "EXAMPLE_VALUE"
    error_message = "Value for 'actions_variables[\"EXAMPLE_VARIABLE\"].value' should be 'EXAMPLE_VALUE'"
  }
}
