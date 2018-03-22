resource "aws_instance" "poc_graylog" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.medium"
  key_name = "${aws_key_pair.poc_graylog_key.key_name}"

  tags {
    Name = "Graylog PoC"
  }
}