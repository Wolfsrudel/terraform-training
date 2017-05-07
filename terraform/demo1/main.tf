# Note: Environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY should be set before running this.

terraform {
  required_version = ">=0.9"
}


variable "aws_region" {
  description = "Region where infrastructure should be created"
  default = "eu-west-1"
}


provider "aws" {
  region = "${var.aws_region}"
}


resource "aws_s3_bucket" "test" {
  bucket = "my-test-bucket-${random_pet.bucket.id}"
}

resource "random_pet" "bucket" {
  keepers = {
    aws_region = "${var.aws_region}"
  }

  length = 2
}

data "aws_caller_identity" "this" {}


output "s3_bucket_test_arn" {
  value = "${aws_s3_bucket.test.arn}"
}