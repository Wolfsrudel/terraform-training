# Note: Environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY should be set before running this.

terraform {
 backend "s3" {
   bucket     = "my-tf-states-anton-demo"
   key        = "demo2"
   region     = "eu-west-1"
   lock_table = "terraform_locks"
   encrypt    = true
 }
}

provider "aws" {
  region = "${var.aws_region}"
}


resource "aws_iam_group" "developers" {
  name = "developers"
}

resource "aws_iam_group_policy_attachment" "developers_poweruseraccess" {
  group      = "${aws_iam_group.developers.name}"
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_user" "users" {
  count = "${length(var.iam_users)}"

  name = "${element(var.iam_users, count.index)}"
}

resource "aws_iam_access_key" "users" {
  count = "${length(var.iam_users)}"
  user = "${element(aws_iam_user.users.*.id, count.index)}"
}

resource "aws_iam_group_membership" "developers" {
  name = "terraform-developers"

  users = [
    "${aws_iam_user.users.*.name}",
  ]

  group = "${aws_iam_group.developers.name}"
}
