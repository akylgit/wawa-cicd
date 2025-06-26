output "instance_public_ips" {
  description = "Public IPs of all EC2 instances"
  value       = [for instance in aws_instance.web : instance.public_ip]
}

output "instance_ids" {
  description = "Instance IDs"
  value       = [for instance in aws_instance.web : instance.id]
}
