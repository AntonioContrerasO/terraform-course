locals {
  bucket_name = "my-twem-buckert"
}


# import {
#   to = aws_s3_bucket.remote_bucket
#   id = local.bucket_name
# }

# resource "aws_s3_bucket" "remote_bucket" {
#   bucket = local.bucket_name
# }

# resource "aws_s3_bucket_public_access_block" "static_website" {
# bucket = aws_s3_bucket.remote_bucket.id
# block_public_acls = false
# block_public_policy = false
# ignore_public_acls = false
# restrict_public_buckets = false
# }

# removed {

# }
