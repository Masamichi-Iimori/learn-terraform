output "public_subnet1" {
  value = aws_subnet.public_0.id
}

output "public_subnet2" {
  value = aws_subnet.public_1.id
}

output "service_sg" {
  value = module.http_sg.security_group_id
}

output "blue_tg_arn" {
  value = aws_lb_target_group.blue.arn
}

output "green_tg_arn" {
  value = aws_lb_target_group.green.arn
}
