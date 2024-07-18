output "db_name" {
  value = aws_db_instance.test.db_name
}

output "db_user" {
    value = var.db_username
}

output "db_pwd" {
  value = var.db_pwd
  sensitive = true
}

output "db_host" {
  value = aws_db_instance.test.address
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet" {
  value = aws_subnet.public
}

output "bucket_name" {
  value = var.bucket_name
}