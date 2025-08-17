variable "subnet_count" {
  type = number
  default = 2
}

variable "ec2_instance_count" {
    type = number
    default = 1
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami = string
  }))

  validation {
    error_message = "Only t2.micro instances are allow"
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)
    ])
  }

  validation {
    error_message = "Only ubuntu or nginx instances are allow"
    condition = alltrue([
      for config in var.ec2_instance_config_list : contains(["ubuntu","nginx"], config.ami)
    ])
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami = string
    subnet_name = optional(string, "default")
  }))

  validation {
    error_message = "Only t2.micro instances are allow"
    condition = alltrue([
      for key, config in var.ec2_instance_config_map : contains(["t2.micro"], config.instance_type)
    ])
  }

  validation {
    error_message = "Only ubuntu or nginx instances are allow"
    condition = alltrue([
      for key, config in var.ec2_instance_config_map : contains(["ubuntu","nginx"], config.ami)
    ])
  }
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string
  }))

  validation {
    error_message = "Error in the cidr block check your configuration variables"
    condition = alltrue([
      for config in values(var.subnet_config) : can(cidrnetmask(config.cidr_block))
    ])
  }
}
