resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"  # Optional but recommended
  instance_class       = "db.t3.micro"
  multi_az             = true
  username             = "admin"               # Replace with your DB username
  password             = "yourpassword123!"    # Replace with a secure password
  db_name              = "mydatabase"          # Optional: initial DB name
  skip_final_snapshot  = true                  # Avoid snapshot on deletion (optional)

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name

  tags = {
    Name = "mysql-db"
  }
}
