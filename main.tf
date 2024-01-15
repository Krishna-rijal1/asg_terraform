module "vpc" {
  source = "./modules/vpc"
}

module "lb" {
  source         = "./modules/lb"
  subnet1        = module.vpc.subnet1_id
  subnet2        = module.vpc.subnet2_id
  security_group = module.vpc.aws_security_group
  vpc_id         = module.vpc.vpc_id
  asgarn = module.asg.asgarn

}

module "asg" {
  source  = "./modules/asg"
  sg_id   = module.vpc.aws_security_group
  subnet1 = module.vpc.subnet1_id
  subnet2 = module.vpc.subnet2_id
  tg_arn  = module.lb.tg_arn
  load_balancer_arn = module.lb.lb_arn
}