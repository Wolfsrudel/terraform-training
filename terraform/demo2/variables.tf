variable "aws_region" {
  description = "Region where infrastructure should be created"
}

variable "iam_users" {
  description = "List of IAM users to create"
  type = "list"
}