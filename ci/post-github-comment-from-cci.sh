#!/bin/bash

set -e

function print_usage {
  echo
  echo "Usage: post-github-comment-from-cci.sh [OPTIONS]"
  echo
  echo "Post comment on github pull request from CircleCI environment. Pull request number is fetched from the CI_PULL_REQUEST environment variable."
  echo "Repository URL contains username and repository name, which are fetched from CIRCLE_PROJECT_USERNAME and CIRCLE_PROJECT_REPONAME environment variables."
  echo
  echo "Options:"
  echo
  echo -e "  --message\tRequired. The message to post."
  echo -e "  --help\tShow this help text and exit."
  echo
  echo "Example:"
  echo
  echo "  post-github-comment-from-cci.sh --message 'Here we go'"
  echo
}

function assert_not_empty {
  local readonly arg_name="$1"
  local readonly arg_value="$2"

  if [[ -z "$arg_value" ]]; then
    echo "ERROR: The value for '$arg_name' cannot be empty"
    print_usage
    exit 1
  fi
}

function assert_env_var_not_empty {
  local readonly var_name="$1"
  local readonly var_value="${!var_name}"

  if [[ -z "$var_value" ]]; then
    echo "ERROR. Required environment $var_name not set."
    exit 1
  fi
}

function post_github_pr_comment_from_cci {
  local message=""
  local circle_pr_number

  while [[ $# > 0 ]]; do
    local key="$1"

    case "$key" in
      --message)
        message="$2"
        shift
        ;;
      --help)
        print_usage
        exit
        ;;
      *)
        echo "ERROR: Unrecognized option: $key"
        print_usage
        exit 1
        ;;
    esac

    shift
  done

  assert_env_var_not_empty "GITHUB_OAUTH_TOKEN"
  assert_env_var_not_empty "CI_PULL_REQUEST"
  assert_env_var_not_empty "CIRCLE_PROJECT_USERNAME"
  assert_env_var_not_empty "CIRCLE_PROJECT_REPONAME"
  assert_not_empty "--message" "$message"

  circle_pr_number=$(echo "$CI_PULL_REQUEST" | sed 's/.*\/pull\///g')

  # Convert newline into characters \n (taken from http://stackoverflow.com/a/38672741/550451)
  message=$(echo "$message" | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g')

  # Escape double quotes
  message=${message//\"/\\\"}

  echo "{\"body\": \"\`\`\`$message\n\`\`\`\"}" > comment.json

  curl -H "Authorization: token $GITHUB_OAUTH_TOKEN" \
    -X POST https://api.github.com/repos/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/issues/${circle_pr_number}/comments \
    --data @comment.json --fail --silent --show-error

  echo "Success!"
}

post_github_pr_comment_from_cci "$@"
