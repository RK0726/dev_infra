resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_role.id
}

resource "aws_iam_role" "ec2_role" {
  name               = "ec2_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.ec2_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "session_manager_access" {
  role       = aws_iam_role.ec2_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# resource "aws_instance" "ec2" {
#   ami                         = "ami-0091f05e4b8ee6709"
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.web_public_subnet_1a.id
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.web_sg.id]
#   key_name                    = var.KEY_NAME
#   iam_instance_profile        = aws_iam_instance_profile.ec2_profile.id

#   tags = {
#     Name    = "${var.APP_NAME}-instance"
#     AppName = var.APP_NAME
#   }
# }