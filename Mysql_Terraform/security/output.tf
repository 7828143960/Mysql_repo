output "Instance_id_public" {
    value = aws_instance.bastion[*].id
}
output "Instance_id_private" {
    value = aws_instance.private-ec2[*].id
}
output "Bastion_Public_IP" {
    value = aws_instance.bastion.public_ip
}