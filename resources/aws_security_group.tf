resource "aws_security_group" "allow" {
  name = "graylog_security_group"
  description = "Allow basic traffic inbound"
  vpc_id = "${var.VPC_ID}"

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 514
    protocol = "tcp"
    to_port = 514
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 514
    protocol = "udp"
    to_port = 514
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 12201
    protocol = "tcp"
    to_port = 12201
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 12201
    protocol = "udp"
    to_port = 12201
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5555
    protocol = "tcp"
    to_port = 5555
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5555
    protocol = "udp"
    to_port = 5555
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "graylog-poc"
  }
}