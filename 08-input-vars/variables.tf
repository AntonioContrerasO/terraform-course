variable "ec2_instance_type" {
  type = string
  default = "t2.micro"
  description = "The size of managed EC2 instances."

  validation {
    # condition = var.ec2_instance_type == "t2.micro" || var.ec2_instance_type == "t3.micro" 
    # condition = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    condition = startswith(var.ec2_instance_type, "t3")
    error_message = "Only supported instnces t2.micro or t3.micro"
  }
}

variable "ec2_volume_config" {
  type = object({
    size = number
    type = string 
  })
  
  description = "The size and type of the ec2 instance"

  default = {
    size = 10
    type = "gp3"
  }
}

# variable "ec2_volume_size" {
#   type = number
#   description = "The size of the root block volumne of the ec2"
# }

# variable "ec2_volume_type" {
#   type = string
#   description = "volumen type between gp2 and gp3"
# }