output "iam_group_developers" {
  value = "${aws_iam_group_membership.developers.users}"
}

output "iam_users_access_keys" {
  value = "${zipmap(aws_iam_user.users.*.id, aws_iam_access_key.users.*.id)}"
}

output "iam_users_secret_keys" {
  value = "${zipmap(aws_iam_user.users.*.id, aws_iam_access_key.users.*.secret)}"
}
