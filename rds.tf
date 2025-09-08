resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  multi_az             = true
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
}
