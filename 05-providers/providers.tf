terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  region = "us-west-2"
  alias = "us-west2"
}



resource "aws_s3_bucket" "my_bucket1" {
  bucket = "some-random-1234-bucket-1"
}

resource "aws_s3_bucket" "my_bucket2" {
  bucket = "some-random-1234-bucket-12"
  provider = aws.us-west2
}