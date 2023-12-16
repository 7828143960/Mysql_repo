variable "vpc_name" {
  type = string   
  default = "Mysql"
}
variable "vpc_tenancy" {
    type = string
    default = "default"
}
variable "vpc_cidr" {
  type = string  
  default = "10.0.0.0/16"
}
variable "pub_sub_names" {
  type = list(string)  
  default = ["mysql-pub-sub-01", "mysql-pub-sub-02"]
}
variable "pub_cidr" {
  type = list(string)    
  default = ["10.0.0.0/18", "10.0.64.0/18"]
}
variable "pvt_sub_names" {
  type = list(string)    
  default = ["mysql-pvt-sub-01", "mysql-pvt-sub-02"]
}
variable "pvt_cidr" {
  type = list(string)    
  default = ["10.0.128.0/18", "10.0.192.0/18"]
}
variable "pub_instance_name" {
  type = string 
  default = "bastion-instance"
}
variable "pvt_instance_name" {
  type = list(string)  
  default = ["mysql-master","mysql-slave"]  
}
variable "igw_name" {
  type = string   
  default = "mysql-igw"
}
variable "nat_name" {
  type = string   
  default = "mysql-nat"
}
variable "pub_rt_names" {
  type = string   
  default = "mysql-pub-rt-01"
}
variable "pvt_rt_names" {
  type = string   
  default = "mysql-pvt-rt-01"
}
variable "instance_type" {
  type = string   
  default = "t2.micro"
}
variable "sec_grp" {
  type = string   
  default = "mysql_sg"
}
variable "key_name" {
  type = string
  default = "mysql.pem"
}
