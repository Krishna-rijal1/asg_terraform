variable "vpc_cidr" {
  description = "cidr of vpc"
  default     = "10.10.0.0/16"

}

variable "subnet1_cidr" {
  default = "10.10.1.0/24"

}
variable "subnet2_cidr" {
  default = "10.10.2.0/24"

}

variable "region" {
  default = "us-east-1a"

}
variable "region2" {
  default = "us-east-1b"

}


variable "sg_id" {
    type = string
    default = ""  
}


