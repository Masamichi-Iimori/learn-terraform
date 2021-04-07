resource "aws_acm_certificate" "example" {
  domain_name               = data.aws_route53_zone.example.name
  subject_alternative_names = []
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}


# aws-providerが3.0.0以降はこの書き方はエラー
# resource "aws_route53_record" "example_certificate" {
#   name    = aws_acm_certificate.example.domain_validation_options[0].resource_record_name
#   type    = aws_acm_certificate.example.domain_validation_options[0].resource_record_type
#   records = [aws_acm_certificate.example.domain_validation_options[0].resource_record_value]
#   zone_id = data.aws_route53_zone.example.id
#   ttl     = 60
# }

# resource "aws_acm_certificate_validation" "example" {
#   certificate_arn         = aws_acm_certificate.example.arn
#   validation_record_fqdns = [aws_route53_record.example_certificate.fqdn]
# }


resource "aws_route53_record" "example_certificate" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example.zone_id
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.example.arn
  validation_record_fqdns = [for record in aws_route53_record.example_certificate : record.fqdn]
}
