locals {
  double_numbers = [for num in var.numbers_list : num * 2]
  even_numbers   = [for num in var.numbers_list : num if num % 2 == 0]
  first_names = [for person in var.object_list : person.firstname]
}


output "doubles" {
  value = local.double_numbers
}
output "even" {
  value = local.even_numbers
}

output "names" {
  value = local.first_names
}