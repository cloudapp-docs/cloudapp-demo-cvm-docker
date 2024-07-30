resource "random_password" "password_for_mysql" {
  length           = 16
  override_special = "_+-&=!@#$%^()"
}

resource "tencentcloud_mysql_instance" "mysql_master" {
  availability_zone = var.app_main_subnet.availability_zone
  vpc_id            = var.app_main_subnet.vpc_id
  subnet_id         = var.app_main_subnet.subnet_id
  charge_type       = var.charge_type == "PREPAID" ? "PREPAID" : "POSTPAID"
  prepaid_period    = var.charge_prepaid_period
  cpu               = 4
  mem_size          = 8000
  volume_size       = 1000
  instance_name     = "mysql"
  engine_version    = "8.0"
  root_password     = random_password.password_for_mysql.result
  security_groups   = [var.app_internal_sg.security_group_id]
  intranet_port     = 3306

  parameters = {
    sql_mode = "NO_ENGINE_SUBSTITUTION,ERROR_FOR_DIVISION_BY_ZERO,NO_ZERO_DATE,NO_ZERO_IN_DATE,STRICT_TRANS_TABLES"
  }
}

resource "tencentcloud_mysql_instance" "mysql_slave" {
  availability_zone = var.app_slave_subnet.availability_zone
  vpc_id            = var.app_slave_subnet.vpc_id
  subnet_id         = var.app_slave_subnet.subnet_id
  charge_type       = var.charge_type == "PREPAID" ? "PREPAID" : "POSTPAID"
  prepaid_period    = var.charge_prepaid_period
  cpu               = 4
  mem_size          = 8000
  volume_size       = 1000
  instance_name      = "mysql-dr"
  engine_version     = "8.0"
  instance_role      = "dr"
  master_instance_id = tencentcloud_mysql_instance.mysql_master.id
  root_password      = random_password.password_for_mysql.result
  security_groups    = [var.app_internal_sg.security_group_id]
  intranet_port      = 3306

  parameters = {
    sql_mode = "NO_ENGINE_SUBSTITUTION,ERROR_FOR_DIVISION_BY_ZERO,NO_ZERO_DATE,NO_ZERO_IN_DATE,STRICT_TRANS_TABLES"
  }
}
