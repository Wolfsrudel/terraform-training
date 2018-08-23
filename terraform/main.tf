# Tasks:
# 1. Create single AWS EC2 instance (web)
# 2. Add variables for all arguments
# 3. Add data source to fetch ID of default security group

provider "aws" {
  region = "..."
}

resource "aws_instance" "web" {
  # ...
}