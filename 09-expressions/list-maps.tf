locals {
  users_map = {for user in var.users : user.username => user.role... }
  users_map2 = {
    for user, roles in local.users_map : user => {roles = roles}
  }
}

output "users_map" {
  value = local.users_map2
}