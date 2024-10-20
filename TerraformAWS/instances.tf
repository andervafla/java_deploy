resource "aws_instance" "frontend" {
  ami                    = "ami-005fc0f236362e99f" 
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
  ami                    = "ami-005fc0f236362e99f" 
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
  ami                    = "ami-005fc0f236362e99f" 
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key.key_name  
  subnet_id              = aws_subnet.database_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_all_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "DatabaseInstance"
  }
}

resource "aws_instance" "prometheus" {
  ami                    = "ami-005fc0f236362e99f" 
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key.key_name  
  subnet_id              = aws_subnet.prometheus_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_all_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "PrometheusInstance"
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

output "prometheus_public_ip" {
  value = aws_instance.prometheus.public_ip
}