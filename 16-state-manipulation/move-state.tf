# moved {
  
# # }


# data "aws_ami" "ubuntu" {
#   most_recent = true
#   owners      = ["099720109477"]
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# locals {
#   ec2_names = ["instance_1", "instance_2"]
# }


# moved {
#   from = aws_instance.web
#   to = aws_instance.new_list["instance_1"]
# }

# resource "aws_instance" "new_list" {
#   for_each = toset(local.ec2_names)
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"
# }