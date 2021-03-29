resource "aws_vpc" "default" {
  cidr_block           = var.root_segment
  enable_dns_hostnames = true

  tags = {
    Name  = "${var.workspace}-bizoom"
    Group = "${var.workspace}-bizoom"
  }
}
