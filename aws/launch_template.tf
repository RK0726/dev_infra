resource "aws_launch_template" "web_server_template" {
  name                   = "web-server-template"
  image_id               = "ami-0091f05e4b8ee6709"
  instance_type          = "t3a.small"
  key_name               = var.KEY_NAME
  vpc_security_group_ids = [aws_security_group.web_sg.id]
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

  instance_market_options {
    market_type = "spot"
    spot_options {
      spot_instance_type             = "one-time"
      instance_interruption_behavior = "terminate"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-server"
    }
  }
}