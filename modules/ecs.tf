resource "aws_ecs_cluster" "ecs_cluter" {
  name = "${var.name}" - "${terraform.workspace}"
}
