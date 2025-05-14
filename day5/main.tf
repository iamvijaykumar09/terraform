provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "example" {
  key_name   = "terraform-vijay"
  public_key = file("/home/codespace/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow-ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                         = "ami-0e35ddab05955cf57"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.example.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/codespace/.ssh/id_rsa")
    host        = self.public_ip
  }

  tags = {
    Name = "HelloWorld"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "echo '<h1>Hello Nginx User(Vijay)</h1>' | sudo tee /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}
