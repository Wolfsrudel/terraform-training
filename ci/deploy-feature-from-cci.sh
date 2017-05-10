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

function deploy_feature_from_cci {
  assert_env_var_not_empty "TF_HOME"

  # Changing directory to where Terraform configs are
  cd "$TF_HOME"

  # Initiate backend, get required modules
  terraform init -force-copy -input=false -backend=true

  # Run non-interactive plan
  terraform plan -refresh=false -input=false -no-color | tee /tmp/plan_output

  # Leave a comment on related pull-request with content of /tmp/plan_output
  cd ~
  ./ci/post-github-comment-from-cci.sh --message "$(cat /tmp/plan_output)"

  # (Optionally) Open pull-request to master branch (release candidate)

  echo "Success!"
}

deploy_feature_from_cci
