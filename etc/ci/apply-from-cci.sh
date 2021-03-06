#!/bin/bash

set -e

function assert_env_var_not_empty {
  local readonly var_name="$1"
  local readonly var_value="${!var_name}"

  if [[ -z "$var_value" ]]; then
    echo "ERROR. Required environment $var_name not set."
    exit 1
  fi
}

function terraform_apply_from_cci {
  assert_env_var_not_empty "TF_HOME"

  # Changing directory to where Terraform configs are
  cd "$TF_HOME"

  # Run non-interactive apply
  terraform apply -refresh=false -input=false -no-color | tee /tmp/plan_output

  echo "Success!"
}

terraform_apply_from_cci
