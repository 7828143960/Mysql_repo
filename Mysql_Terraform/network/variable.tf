variable "vpc_name" {
  type = string   
}
variable "tenancy" {
    type = string
}
variable "vpc_cidr" {
  type = string  
}
variable "pub_subnet_names" {
  type = list(string)  
}
variable "pub_cidr" {
  type = list(string)    
}
variable "pvt_subnet_names" {
  type = list(string)    
}
variable "pvt_cidr" {
  type = list(string)    
}
variable "igw_name" {
  type = string   
}
variable "nat_name" {
  type = string   
}
variable "pub_rt_names" {
  type = string   
}
variable "pvt_rt_names" {
  type = string   
}
