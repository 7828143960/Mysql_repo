output "vpc_id" {
    value = module.netwoking.vpc_id_print
}
output "pub_subnet_id" {
    value = module.netwoking.pub_subnet_id
}
output "pvt_subnet_id" {
    value = module.netwoking.pri_subnet_id
}
output "Instance_id_public" {
    value = module.Security.Instance_id_public
}
output "Instance_id_private" {
    value = module.Security.Instance_id_private
}
output "IP_Public_Bastion" {
    value = module.Security.Bastion_Public_IP
}