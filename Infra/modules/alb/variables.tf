variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  type = list(string)
}


variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "instance_id" {
  description = "EC2 Instance ID"
  type        = string
}
