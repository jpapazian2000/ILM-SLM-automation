output "ec2_first_addr" {
  value = aws_instance.target[0].public_ip
}

output "ec2_second_addr" {
  value = aws_instance.target[1].public_ip
}

output "key_name" {
  value = aws_key_pair.boundary.key_name
}

output "security_group" {
  value = aws_security_group.worker.id
}