# Create S3 bucket
resource aws_s3_bucket uko_aws_demo_bucket {
  depends_on = [data.aws_kms_key.aws_key_from_uko]
  bucket = var.aws_s3_bucket_name
}

# Enable Server Side encryption using the key that is just deployed by UKO
resource aws_s3_bucket_server_side_encryption_configuration aws_s3_bucket_encryption {
  bucket = aws_s3_bucket.uko_aws_demo_bucket.bucket

  # Now, set the rule to encrypt pointing it at the key
  # created and pushed by UKO
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = data.aws_kms_key.aws_key_from_uko.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Push data to the newly created bucket
resource aws_s3_object object {
  bucket = aws_s3_bucket.uko_aws_demo_bucket.bucket
  key    = "uko_aws_s3_demo_sample_data"
  source = "uko_aws_s3_sample_data.txt"
  etag = filemd5("uko_aws_s3_sample_data.txt")
}
