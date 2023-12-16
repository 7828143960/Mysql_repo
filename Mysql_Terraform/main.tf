module "netwoking" {
    source = "./network"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name
    tenancy = var.vpc_tenancy
    pub_subnet_names = var.pub_sub_names
    pub_cidr = var.pub_cidr
    pvt_subnet_names = var.pvt_sub_names
    pvt_cidr = var.pvt_cidr
    igw_name = var.igw_name
    nat_name = var.nat_name
    pub_rt_names = var.pub_rt_names
    pvt_rt_names = var.pvt_rt_names
}

module "Security" {
    source = "./security"
    bastion_instance_name = var.pub_instance_name
    pvt_instance_name = var.pvt_instance_name
    instance_type = var.instance_type
    sec_grp = var.sec_grp
    key_name = var.key_name
    pub_sub_id = module.netwoking.pub_subnet_id[0]
    pvt_sub_id = module.netwoking.pvt_subnet_id
    vpc_id = module.netwoking.vpc_id

}
