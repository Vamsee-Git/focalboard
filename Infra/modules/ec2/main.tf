data "aws_ssm_parameter" "amazon_linux_2" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "focalboard" {
  ami                    = data.aws_ssm_parameter.amazon_linux_2.value
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  security_groups        = [var.security_groups]

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
