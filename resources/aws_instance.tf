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

  provisioner "file" {
    source = "../graylog_config/"
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_docker.sh && sudo /tmp/install_docker.sh ubuntu"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "docker-compose -f /tmp/graylog-compose.yml up -d"
    ]
  }

  tags {
    Name = "graylog-poc"
  }
}
