resource "aws_autoscaling_group" "asg" {
  name             = "ec2-asg"
  max_size         = 1
  min_size         = 1
  desired_capacity = 1
  vpc_zone_identifier = [
    aws_subnet.web_public_subnet_1a.id,
    aws_subnet.web_public_subnet_1c.id
  ]
  launch_template {
    id      = aws_launch_template.web_server_template.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
  termination_policies      = ["OldestInstance"]
  tag {
    key                 = "Name"
    value               = "web-server"
    propagate_at_launch = true //インスタンスにタグをつける
  }
}