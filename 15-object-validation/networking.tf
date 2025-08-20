data "aws_vpc" "default" {
  default = true
}

resource "aws_subnet" "this" {
  vpc_id = data.aws_ami.ubuntu.id
  cidr_block = "172.31.128.0/24"

  lifecycle {
    postcondition {
      condition = self.availability_zone == "us-west-1a"
      error_message = "Invalid AZ"
    }
  }
}