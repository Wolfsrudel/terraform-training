# Note: Environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY should be set before running this.
//export AWS_ACCESS_KEY_ID=...
//export AWS_SECRET_ACCESS_KEY=...
//export AWS_DEFAULT_REGION=eu-west-1
//aws s3 ls

terraform {
  required_version = ">=0.9"

 backend "s3" {
   bucket     = "my-tf-states-anton-demo"
   key        = "user6"
   region     = "eu-west-1"
   lock_table = "terraform_locks"
   encrypt    = true
 }
}

data "terraform_remote_state" "user2" {
 backend = "s3"

 config {
   bucket  = "my-tf-states-anton-demo"
   region  = "eu-west-1"
   key     = "user2"
   encrypt = true
 }
}

output "user2_s3_bucket_test_arn" {
 value = "${data.terraform_remote_state.user2.s3_bucket_test_arn}"
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


output "s3_bucket_test_arn" {
  value = "${aws_s3_bucket.test.arn}"
}

output "s3_bucket_test_bucket" {
  value = "${aws_s3_bucket.test.bucket_domain_name}"
}