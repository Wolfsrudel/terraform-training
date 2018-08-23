# demo2

Code for "Continuously delivering infrastructure using Terraform" training.

Terraform configurations which create IAM users, group and assign users to the group.

## Commands:

1. terraform init
1. terraform plan
1. terraform apply

## Print `access_key` and `secret_key` for `user1`:

1. terraform output -json iam_users_access_keys | jq -r '.value.user1'
1. terraform output -json iam_users_secret_keys | jq -r '.value.user1'

## Notes:

* Environment variables `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` should be set before running code in `terraform` directory.
* `terraform.tfstate` file contains secrets and ignored by `.gitignore`, so be careful when running this example from different places as you may see errors.
