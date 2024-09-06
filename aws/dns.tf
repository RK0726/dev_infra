resource "aws_route53_zone" "tskt" {
  name = "tskt.net"

  tags = {
    Name    = "${var.APP_NAME}-hosted-zone"
    AppName = var.APP_NAME
  }
}