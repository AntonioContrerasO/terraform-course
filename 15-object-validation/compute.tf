locals {
  allowed_instance_type = ["t2.micro", "t3.micro"]
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "this" {
  state = "available"
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.this.id

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  lifecycle {
    create_before_destroy = true
    # precondition {
    #   condition     = contains(local.allowed_instance_type, var.instance_type)
    #   error_message = "Invalid instance type"
    # }

    # postcondition {
    #   condition = contains(local.allowed_instance_type, self.instance_type)
    #   error_message = "Self invalid instance type"
    # }

    postcondition {
      condition = contains(data.aws_availability_zones.this.names, self.availability_zone)
      error_message = "Invalid AZ"
    }

  }


}

check "cost_center_check" {
  assert {
    condition = can(aws_instance.web.tags.CostCenter != "")
    error_message = "AWS instance dose not have a CostCenter Tag" 
  }
}