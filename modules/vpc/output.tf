output "vpc_id" {
  value = aws_vpc.krishna.id

}
output "subnet1_id" {
  value = aws_subnet.subnet1.id

}
output "subnet2_id" {
  value = aws_subnet.subnet2.id

}
output "aws_security_group" {
  value = aws_security_group.sg.id

}