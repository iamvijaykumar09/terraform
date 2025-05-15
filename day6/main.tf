provider "aws"{
    region = "ap-south-1"
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

#commands
/*
terraform workspace new dev
terraform workspace new test
terraform workspace select dev/test
terraform workspace show
terraform workspace list
terraform workspace delete dev/test
*/