resource "aws_route53_record" "logging" {
  name = "${var.RECORD_SET_NAME}"
  type = "CNAME"
  zone_id = "${var.HOSTED_ZONE_ID}"
  ttl = "60"
  records = ["${aws_instance.poc_graylog.public_dns}"]
}