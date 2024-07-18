output "test" {
  value = "${var.tag}-${random_pet.test.id}-worker-0"
}