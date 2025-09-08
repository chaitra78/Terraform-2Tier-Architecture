module "db" {
  source = "terraform-aws-modules/rds/aws"
 
  identifier = "rds-expense-dev"
 
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 5
 
  db_name  = "transactions" #database name inside rds 
  username = "root"
  port     = "3306"
  manage_master_user_password = false
  password = "ExpenseApp1"
  multi_az             = true # Add this line for a Multi-AZ deployment
 
 
  vpc_security_group_ids = [local.web_sgl_sg]
 
    #  subnet ids---> no need to mention subnet ids since we use subnet groups .. subnet group
  # already has subnet ids
 
  db_subnet_group_name = local.database_subnet_group
  # DB parameter group
  family = "mysql5.7"
 
  # DB option group
  major_engine_version = "5.7"
 
  # Database Deletion Protection
  # deletion_protection = true
  skip_final_snapshot = true
 
 
  # maintenance_window = "Mon:00:00-Mon:03:00"
  # backup_window      = "03:00-06:00"
 
  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
 
  # monitoring_interval    = "30"
  # monitoring_role_name   = "MyRDSMonitoringRole"
  # create_monitoring_role = true
 
  tags = {
    Project       = "expense"
    Environment = "dev"
  }
}