resource "boundary_storage_bucket" "aws_s3" {
  name            = "EC2 SSH Session Recording"
  description     = "Bucket to store SSH session recordings"
  scope_id        = boundary_scope.global.id
  plugin_name     = "aws"
  bucket_name     = data.terraform_remote_state.aws_infra.outputs.bucket_name
  attributes_json = jsonencode({
    "region" = "us-east-1"
    "disable_credential_rotation" = true
  })
  # recommended to pass in aws secrets using a file() or using environment variables
  # the secrets below must be generated in aws by creating a aws iam user with programmatic access
  secrets_json = jsonencode({
    "access_key_id"     = var.aws_key_id,
    "secret_access_key" = var.aws_secret_key
  })
  worker_filter = "name matches \"${var.worker_name}-0\""
  depends_on = [ aws_instance.worker ]
}