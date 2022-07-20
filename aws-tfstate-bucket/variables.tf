variable "aws_region" {
  description = "The AWS region to deploy to (e.g. eu-west-1)"
  type = string
}

variable "aws_account_id" {
  description = "AWS account to hold the state file buckets."
  type = string
}

variable "bucket_name" {
  description = "Bucket name"
  type = string
}
