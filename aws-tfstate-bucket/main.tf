locals {
  tags = {
    squad = "devops"
    env = "dev",
    heritage = "tf",
    src = "terraform-modules/aws-tfstate-bucket",
    Name = var.bucket_name,
    application = "devops",
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl = "private"

  # indicates that all objects (including any locked objects) should be deleted from the bucket
  # so that the bucket can be destroyed without error.
  force_destroy = true
  tags = local.tags

  versioning {
    enabled = true
  }

  // use standard S3 encryption at rest
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id = "delete-outdated"
    enabled = true

    prefix = ""

    # I would prefer to keep older versions for some extra time.
    # It's unlikely, but possible that specific prosision will not be update for long time and previous version might by gone
    noncurrent_version_expiration {
      days = 365
    }
  }
}

resource "aws_s3_bucket_public_access_block" "state" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_policy" "state" {
  bucket = aws_s3_bucket.bucket.id
  depends_on = [
    aws_s3_bucket_public_access_block.state]

  policy = jsonencode(
  {
    "Version" : "2008-10-17",
    "Id" : "S3-Encryption-Policy",
    "Statement" : [
      {
        Sid: "DenyIncorrectEncryptionHeader",
        Effect: "Deny",
        Principal: "*",
        Action: "s3:PutObject",
        Resource: "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*",
        Condition: {
          StringNotEquals: {
            "s3:x-amz-server-side-encryption": "AES256"
          }
        }
      },
      {
        Sid: "DenyUnEncryptedObjectUploads",
        Effect: "Deny",
        Principal: "*",
        Action: "s3:PutObject",
        Resource: "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*",
        Condition: {
          "Null": {
            "s3:x-amz-server-side-encryption": "true"
          }
        }
      }
    ]
  }
  )
}
