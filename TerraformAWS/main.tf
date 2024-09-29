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
    Name = "MyFirstInstance"
  }

  user_data = file("D:/internship-project/internship_project/TerraformAWS/setupFront.sh")

}

# Create a security group to allow HTTP traffic
resource "aws_security_group" "instance_sg" {
  name        = "allow_http"
  description = "Allow HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
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

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
