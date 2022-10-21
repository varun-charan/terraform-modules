output "state_bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "arn of the provided s3 bucket"
}

output "state_bucket_name" {
  value       = aws_s3_bucket.bucket.bucket
  description = "name (id) of the provided s3 bucket"
}

