resource "aws_route53_zone" "tskt" {
  name = "tskt.net"

  tags = {
    Name    = "${var.APP_NAME}-hosted-zone"
    AppName = var.APP_NAME
  }
}

resource "aws_route53_record" "tskt_a" {
  zone_id = aws_route53_zone.tskt.zone_id
  name    = "tskt.net"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2.public_ip]
}