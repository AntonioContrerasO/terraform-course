locals {
  name = "Lauro Muller"
  age = 15
}

output "example" {
  value = startswith(lower(local.name), "John")
}