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
