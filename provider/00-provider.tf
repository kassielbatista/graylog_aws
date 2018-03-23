# Configuring AWS Provider
provider "aws" {
  access_key = "${var.aws-provider["aws_key"]}"
  secret_key = "${var.aws-provider["aws_secret"]}"
  region     = "${var.aws-provider["aws_region"]}"
}
