output "alb_dns" {
    value = aws_alb.load_balancer.dns_name
}

output "lb_arn" {
    value = aws_alb.load_balancer.arn
}

output "tg_arn" {
    value = aws_lb_target_group.target_group.arn
}