resource "aws_route53_zone" "tskt" {
  name = "tskt.net"

  tags = {
    Name    = "public-hosted-zone"
  }
}

resource "aws_route53_record" "tskt_a" {
  zone_id = aws_route53_zone.tskt.zone_id
  name    = "tskt.net"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2.public_ip]
}

#### Private DNS ####
resource "aws_route53_zone" "tskt_private" {
  name = "internal.tskt.net"
  vpc {
    vpc_id = aws_vpc.vpc.id
  }

  tags = {
    Name    = "private-hosted-zone"
  }
}

resource "aws_route53_record" "tskt_private_a" {
  zone_id = aws_route53_zone.tskt_private.zone_id
  name    = "internal.tskt.net"
  type    = "A"
  ttl     = 300
  records = [aws_instance.ec2.private_ip]
}