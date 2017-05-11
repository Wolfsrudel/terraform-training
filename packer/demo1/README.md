# Demo Application AMI

Code for "Continuously delivering infrastructure using Terraform" training.

There is a basic Packer config example, which uses `amazon-ebs` builder.

## Build the AMI

1. Install [Packer](https://www.packer.io/).
1. Set up your [AWS credentials as environment variables](https://www.packer.io/docs/builders/amazon.html).
1. Run `packer build app.json` to create a new AMI in your AWS account.
You can specify AWS region you want to use like this: `packer build -var 'aws_region=eu-central-1' app.json`.
1. Note down the ID of this new AMI.
