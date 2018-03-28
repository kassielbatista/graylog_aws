resource "aws_instance" "poc_graylog" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.medium"
  key_name      = "${aws_key_pair.poc_graylog_key.key_name}"
  vpc_security_group_ids = ["${aws_security_group.allow.id}"]
  subnet_id = "${aws_subnet.subnet.id}"

  connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.SSH_PRIVATE_KEY}")}"
  }

  provisioner "file" {
    source = "../scripts/"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo /tmp/install_docker.sh"
    ]
  }

  tags {
    Name = "graylog-poc"
  }
}
