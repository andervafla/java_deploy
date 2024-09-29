terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" 
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("D:/internship-project/internship_project/TerraformAWS/key/my-key.pub") 
}

resource "aws_instance" "example" {
  ami           = "ami-0e86e20dae9224db8" 
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name  

  tags = {
    Name = "MyFirs"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              EOF
}

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
