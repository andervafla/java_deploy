
resource "aws_instance" "frontend" {
  ami                    = "ami-0e86e20dae9224db8" 
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key.key_name  
  subnet_id              = aws_subnet.frontend_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_all_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "FrontendInstance"
  }
}

resource "aws_instance" "backend" {
  ami                    = "ami-0e86e20dae9224db8" 
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key.key_name  
  subnet_id              = aws_subnet.backend_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_all_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "BackendInstance"
  }
}

resource "aws_instance" "database" {
  ami                    = "ami-0e86e20dae9224db8" 
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key.key_name  
  subnet_id              = aws_subnet.database_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_all_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "DatabaseInstance"
  }
}

output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}

output "backend_public_ip" {
  value = aws_instance.backend.public_ip
}

output "database_public_ip" {
  value = aws_instance.database.public_ip
}
