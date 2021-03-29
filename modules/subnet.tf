resource "aws_subnet" "public_a" {
  availability_zone = "${var.region}a"
  cidr_block        = lookup(var.subnet_public_a, "${terraform.workspace}", var.subnet_public_a["default"])
  vpc_id            = aws_vpc.default.id
}

resource "aws_subnet" "public_c" {
  availability_zone = "${var.region}c"
  cidr_block        = var.subnet_public_c
  vpc_id            = aws_vpc.default.id
}
