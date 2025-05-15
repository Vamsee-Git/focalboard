resource "aws_instance" "focalboard" {
  ami                    = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  security_groups        = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              docker run -d --name focalboard -p 8000:8000 mattermost/focalboard
              EOF

  tags = {
    Name = "Focalboard"
  }
}

output "instance_id" {
  value = aws_instance.focalboard.id
}

output "instance_public_ip" {
  value = aws_instance.focalboard.public_ip
}
