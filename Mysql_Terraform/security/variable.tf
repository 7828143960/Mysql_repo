variable "bastion_instance_name" {
  type = string 
}
variable "pvt_instance_name" {
  type = list(string)    
}
variable "instance_type" {
  type = string   
}
variable "sec_grp" {
  type = string   
}
variable "key_name" {
  type = string
}
variable "pub_sub_id" {
  type = string
}
variable "pvt_sub_id" {
  type = list(string)
}
variable "vpc_id" {
  type = string
}