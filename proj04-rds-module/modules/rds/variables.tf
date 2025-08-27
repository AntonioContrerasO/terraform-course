########################

# General Config

########################
variable "project_name" {
  type = string
}

variable "instance_class" {
    type = string
    default = "db.t3.micro"
    validation {
    condition = contains(["db.t3.micro"], var.instance_class)
    error_message = "Only db.t3.micro is allowed" 
    }
}

variable "storage_size" {
  type = number
  default = 10
  validation {
    condition = var.storage_size > 5 && var.storage_size <= 10
    error_message = "DB storage must be between 5 GB and 10 GB"
  }
}

variable "engine" {
  type = string
  default = "postgres-latest"
  validation {
    condition = contains(["postgres-latest", "postgres-14"], var.engine)
    error_message = "DB engine must be postgres-latest or postgres-14"
  }
}

########################

# DB Credentials

########################

variable "credentials" {
  type = object({
    username = string
    password = string 
  })
  sensitive = true

  validation {
    condition = (
        length(regexall("[a-zA-Z]+", var.credentials.password)) > 0
        && length(regexall("[0-9]+", var.credentials.password)) > 0
        && length(regexall("^[a-zA-z0-9+_?-]{6,}$", var.credentials.password)) > 0
    )
    error_message = "Password should be longer than 6 characters"
  }
}

########################

# Database network

########################

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
    type = list(string)
  
}

