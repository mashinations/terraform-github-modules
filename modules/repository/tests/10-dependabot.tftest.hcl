run "_setup_" {
  command = apply
  module { source = "./tests/setup" }
  variables { test_suite = "dependabot" }
}

## ============================================================================================== ##
##                          Test - Default Values for Repository Settings                         ##
## ============================================================================================== ##
run "check_defaults" {
  command = apply
  variables {
    name     = run._setup_.repository_name
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.dependabot_secrets
    condition     = length(output.dependabot_secrets) == 0
    error_message = "Default value for 'dependabot_secrets' should be empty"
  }
}

## ============================================================================================== ##
##                         Test - Feature Configuration Enabled - Secrets                         ##
## ============================================================================================== ##
run "check_feature_enabled_secrets" {
  command = apply
  variables {
    name = run._setup_.repository_name
    dependabot = {
      secrets = {
        EXAMPLE_SECRET_ENCRYPTED = { value = "lLYvhF5ho2i2x5U16fI3Z2Y9raEbXD0yFn09IDUQX1bXrHAbi/gJYpq833H4k1+Xm9/rH2o2/y3Lcmm6ekA8TeHVqbKwWZw=" }
        EXAMPLE_SECRET_PLAINTEXT = { value = "EXAMPLE_VALUE_PLAINTEXT", value_type = "plaintext" }
      }
    }
    settings = { archive_on_destroy = run._setup_.archive_repository }
  }

  assert { ## output.dependabot_secrets["EXAMPLE_SECRET_ENCRYPTED"]
    condition     = output.dependabot_secrets["EXAMPLE_SECRET_ENCRYPTED"] != null
    error_message = "Value for 'dependabot_secrets[\"EXAMPLE_SECRET_ENCRYPTED\"]' should not be null"
  }
  assert { ## output.dependabot_secrets["EXAMPLE_SECRET_PLAINTEXT"]
    condition     = output.dependabot_secrets["EXAMPLE_SECRET_PLAINTEXT"] != null
    error_message = "Value for 'dependabot_secrets[\"EXAMPLE_SECRET_PLAINTEXT\"]' should not be null"
  }
}
