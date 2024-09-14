resource "aws_launch_template" "web_server_template" {
  name                 = "web-server-template"
  image_id             = "ami-0091f05e4b8ee6709"
  instance_type        = "t2.micro"
  key_name             = var.KEY_NAME
  security_group_names = [aws_security_group.web_sg.name]
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.id
  }
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 30
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-server"
    }
  }
}