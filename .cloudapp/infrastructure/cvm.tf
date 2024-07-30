resource "random_password" "passwor_for_cvm" {
  length           = 16
  override_special = "_+-&=!@#$%^()"
}


resource "tencentcloud_instance" "cvm_job_main" {
  availability_zone                   = var.app_main_subnet.availability_zone
  instance_charge_type                = var.charge_type == "PREPAID" ? "PREPAID" : "POSTPAID_BY_HOUR"
  instance_charge_type_prepaid_period = var.charge_prepaid_period
  image_id                            = var.cvm_job_main_image_id
  instance_type                       = var.cvm_instance_quality.instance_type #"S6.2XLARGE32"
  system_disk_size                    = 50
  vpc_id                              = var.app_main_subnet.vpc_id
  subnet_id                           = var.app_main_subnet.subnet_id
  security_groups                     = [var.app_internal_sg.security_group_id]
  internet_max_bandwidth_out          = 100
  password                            = random_password.passwor_for_cvm.result
  data_disks {
    data_disk_type = "CLOUD_PREMIUM"
    data_disk_size = 200
  }

  user_data_raw = <<-EOT
  #!/bin/bash

  cd /opt/projects/docker/
  echo "" > infrastructure.info

  echo "MYSQL_DATABASE=app_redis" >> infrastructure.info
  echo "MYSQL_USERNAME=root" >> infrastructure.info
  echo "MYSQL_PASSWORD=${random_password.password_for_mysql.result}" >> infrastructure.info
  echo "MYSQL_HOST=${tencentcloud_mysql_instance.mysql_master.intranet_ip}" >> infrastructure.info
  echo "MYSQL_PORT=${tencentcloud_mysql_instance.mysql_master.intranet_port}" >> infrastructure.info
  echo "REDIS_DATABASE=1" >> infrastructure.info
  echo "REDIS_HOST=${tencentcloud_redis_instance.redis_cluster.ip}" >> infrastructure.info
  echo "REDIS_PASSWORD=8bXpbPwJJe022" >> infrastructure.info
  
  sh init_conf.sh
  sh init_db.sh
  sh init_app.sh
  EOT
}

# cvm 主实例
resource "tencentcloud_instance" "cvm_app_main" {
  availability_zone                   = var.app_main_subnet.availability_zone
  instance_charge_type                = var.charge_type == "PREPAID" ? "PREPAID" : "POSTPAID_BY_HOUR"
  instance_charge_type_prepaid_period = var.charge_prepaid_period
  image_id                            = var.cvm_app_main_image_id
  instance_type                       = var.cvm_instance_quality.instance_type #"S6.2XLARGE32"
  system_disk_size                    = 50
  vpc_id                              = var.app_main_subnet.vpc_id
  subnet_id                           = var.app_main_subnet.subnet_id
  security_groups                     = [var.app_internal_sg.security_group_id]
  internet_max_bandwidth_out          = 100
  password                            = random_password.passwor_for_cvm.result
  data_disks {
    data_disk_type = "CLOUD_PREMIUM"
    data_disk_size = 200
  }

  user_data_raw = <<-EOT
  #!/bin/bash

  cd /opt/projects/docker/
  echo "" > infrastructure.info

  echo "MYSQL_DATABASE=app_db" >> infrastructure.info
  echo "MYSQL_USERNAME=root" >> infrastructure.info
  echo "MYSQL_PASSWORD=${random_password.password_for_mysql.result}" >> infrastructure.info
  echo "MYSQL_HOST=${tencentcloud_mysql_instance.mysql_master.intranet_ip}" >> infrastructure.info
  echo "MYSQL_PORT=${tencentcloud_mysql_instance.mysql_master.intranet_port}" >> infrastructure.info
  echo "REDIS_DATABASE=1" >> infrastructure.info
  echo "REDIS_HOST=${tencentcloud_redis_instance.redis_cluster.ip}" >> infrastructure.info
  echo "REDIS_PASSWORD=8bXpbPwJJe022" >> infrastructure.info
  echo "BANKEND_JOB_HOST=${tencentcloud_instance.cvm_job_main.private_ip}" >> infrastructure.info
  
  sh init_conf.sh
  sh init_db.sh
  sh init_app.sh
  EOT
}

# cvm 容灾实例
resource "tencentcloud_instance" "cvm_slave" {
  availability_zone                   = var.app_slave_subnet.availability_zone
  instance_charge_type                = var.charge_type == "PREPAID" ? "PREPAID" : "POSTPAID_BY_HOUR"
  instance_charge_type_prepaid_period = var.charge_prepaid_period
  image_id                            = var.cvm_app_main_image_id
  instance_type                       = var.cvm_instance_quality.instance_type #"S6.2XLARGE32"
  system_disk_size                    = 50
  vpc_id                              = var.app_slave_subnet.vpc_id
  subnet_id                           = var.app_slave_subnet.subnet_id
  security_groups                     = [var.app_internal_sg.security_group_id]
  internet_max_bandwidth_out          = 100
  password                            = random_password.passwor_for_cvm.result
  data_disks {
    data_disk_type = "CLOUD_PREMIUM"
    data_disk_size = 200
  }
  test_text = tencentcloud_instance.cvm_app_main.id

  user_data_raw = <<-EOT
  #!/bin/bash

  cd /opt/projects/docker/
  echo "" > infrastructure.info

  echo "MYSQL_DATABASE=app_db" >> infrastructure.info
  echo "MYSQL_USERNAME=root" >> infrastructure.info
  echo "MYSQL_PASSWORD=${random_password.password_for_mysql.result}" >> infrastructure.info
  echo "MYSQL_HOST=${tencentcloud_mysql_instance.mysql_master.intranet_ip}" >> infrastructure.info
  echo "MYSQL_PORT=${tencentcloud_mysql_instance.mysql_master.intranet_port}" >> infrastructure.info
  echo "REDIS_DATABASE=1" >> infrastructure.info
  echo "REDIS_HOST=${tencentcloud_redis_instance.redis_cluster.ip}" >> infrastructure.info
  echo "REDIS_PASSWORD=8bXpbPwJJe022" >> infrastructure.info
  echo "BANKEND_JOB_HOST=${tencentcloud_instance.cvm_job_main.private_ip}" >> infrastructure.info
  
  sh init_conf.sh
  sh init_app.sh
  EOT
}
