variable "numbers_list" {
  type = list(number)
}

variable "object_list" {
  type = list(object({
    firstname = string
    lastname  = string
  }))
}

variable "numbers_map" {
  type = map(number)
}

variable "users" {
  type = list(object({
    username = string
    role = string
  }))
}