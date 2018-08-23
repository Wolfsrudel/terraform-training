variable "region" {
  description = "The AWS region in which to provision resources"
  default     = "us-east-1"
}

variable "security_group_id" {
  description = "The security group with ingress and egress rules that EC2 instances will be created within."
}

variable "identity" {
  description = "A unique name for your resources"
}

variable "ami" {
  description = "The Amazon Machine Image for new instances."
}

variable "num_webs" {
  description = "The number of servers to run"
  default     = "1"
}

provider "aws" {
  region = "${var.region}"
}

### Solution for Task 1
resource "aws_instance" "web" {
  ami           = "ami-04169656fea786776" # hint: https://cloud-images.ubuntu.com/locator/ec2/
  instance_type = "t3.micro"

  subnet_id              = "subnet-c02e6198" # check AWS console
  vpc_security_group_ids = ["sg-b1fe76ca"]   # check AWS console

  tags {
    "Identity" = "..." # put unique name here
  }
}

//### Solution for Task 2 - variables
//resource "aws_instance" "web" {
//  ami           = "${var.ami}" # hint: https://cloud-images.ubuntu.com/locator/ec2/
//  instance_type = "t3.micro"
//
//  subnet_id              = "subnet-c02e6198" # check AWS console
//  vpc_security_group_ids = ["${var.security_group_id}"]   # check AWS console
//
//  tags {
//    "Identity" = "${var.identity}"
//  }
//}

//### Solution for Task 3 - data-sources
//data "aws_security_group" "default" {
//  name = "default"
//}
//
//resource "aws_instance" "web" {
//  ami           = "${var.ami}" # hint: https://cloud-images.ubuntu.com/locator/ec2/
//  instance_type = "t3.micro"
//
//  subnet_id              = "subnet-c02e6198" # check AWS console
//  vpc_security_group_ids = ["${data.aws_security_group.default.id}"]
//
//  tags {
//    "Identity" = "${var.identity}"
//  }
//}
