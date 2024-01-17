resource "aws_launch_configuration" "test-config" {
  name   = "krishna"
  image_id      = var.aws-ami
  instance_type = var.instance_type
  security_groups = [var.sg_id]
  key_name = "krishna"
  associate_public_ip_address = true
  user_data = <<-EOF
      #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
    # name = "testing"
    max_size = 4
    min_size = 2
    desired_capacity = 2
    launch_configuration = aws_launch_configuration.test-config.id
    vpc_zone_identifier = [var.subnet1, var.subnet2]
    health_check_grace_period = 300
    health_check_type = "ELB"
    target_group_arns = [var.tg_arn]
}
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.asg.id
  policy_type = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "Alarm for cpu up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 40

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.id
  }

  alarm_description = "This metric monitors EC2 CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.scale_up.arn]
}


resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down_policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.asg.id
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "Alarm for cpu down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 50

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.id
  }

  alarm_description = "This metric monitors EC2 CPU utilization"
  alarm_actions     = [aws_autoscaling_policy.scale_down.arn]
}
