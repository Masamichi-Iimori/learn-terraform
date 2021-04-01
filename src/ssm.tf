resource "aws_ssm_parameter" "db_password" {
  name        = "/db/password"
  value       = "uninitialized"
  type        = "SecureString"
  description = "データベースのパスワード"
  overwrite   = true

  lifecycle {
    ignore_changes = [value]
  }
}
