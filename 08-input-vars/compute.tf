locals {
  project = "08-input-vars-locals"
  project_owner = "terraform-course"
  cost_center = "1234"
  managed_by = "Terraform"

}

locals {
  common_tags = {
    owner = local.project_owner
    cost_center = local.cost_center
    managed_by = local.managed_by
  }
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


resource "aws_instance" "compute" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_config.size
    volume_type           = var.ec2_volume_config.type
  }
  tags = local.common_tags
}