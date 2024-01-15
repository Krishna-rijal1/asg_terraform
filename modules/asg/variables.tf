variable "aws-ami" {
    type = string
    default = "ami-0c7217cdde317cfec"
  
}

variable "instance_type" {
    default = "t2.micro"
  
}

variable "sg_id" {
    default = ""
  
}
variable "subnet1" {
    default = ""
  
}
variable "subnet2" {
    default = ""
  
}
variable "tg_arn" {
    default = ""
  
}

variable "load_balancer_arn" {}