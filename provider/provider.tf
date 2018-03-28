# Configuring AWS Provider
provider "aws" {
  access_key = "${var.AWS_KEY}"
  secret_key = "${var.AWS_SECRET}"
  region     = "${var.AWS_REGION}"
}
