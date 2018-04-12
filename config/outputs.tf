output "public_ip" {
  value = "${aws_instance.poc_graylog.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.poc_graylog.public_dns}"
}