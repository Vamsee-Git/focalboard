provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-backend-vamsee"
    key            = "terraform/focalboard/statefile"
    region         = "us-west-1"
    encrypt        = true
  }
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source             = "./modules/ec2"
  vpc_id             = module.vpc.vpc_id
  subnet_id          = module.vpc.subnet_ids[0]
  security_group_id  = module.vpc.security_group_id
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids          = module.vpc.subnet_ids
  security_group_id  = module.vpc.security_group_id
  instance_id        = module.ec2.instance_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
