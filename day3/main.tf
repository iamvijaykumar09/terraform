provider "aws" {
  region = "ap-south-1"
}

module "ec2_instance" {
 source = "./modules/ec2_instance"
 ami_value = "ami-0e35ddab05955cf57"
 instance_type = "t2.micro"
}
