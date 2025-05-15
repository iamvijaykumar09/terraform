provider "aws" {
  region = "ap-south-1"
  //shared_credentials_files = [ "/workspaces/terraform/day7/credentials" ]
}

variable "instance_type" {
  default = "t2.micro"
}

locals {
  instance_name = "${terraform.workspace}-instance"
}

resource "aws_instance" "vm" {
  ami = "ami-0e35ddab05955cf57"

  instance_type = var.instance_type

  tags = {
    Name = local.instance_name
  }
}

//using environmtent variables
/*
export AWS_ACCESS_KEY_ID = ""
export AWS_SECRET_ACCESS_KEY = ""
*/