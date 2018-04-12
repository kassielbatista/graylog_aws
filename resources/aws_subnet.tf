resource "aws_subnet" "subnet" {
  vpc_id = "${var.VPC_ID}"
  cidr_block = "10.10.133.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.AWS_AVAILABILITY_ZONE}"

  tags {
    Name = "graylog-poc"
  }
}