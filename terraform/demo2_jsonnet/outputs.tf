output "iam_group_developers" {
  value = "${sort(aws_iam_group_membership.developers.users)}"
}
