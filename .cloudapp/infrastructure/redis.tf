resource "random_password" "password_for_redis" {
  length           = 16
  override_special = "_+-&=!@#$%^()"
}

resource "tencentcloud_redis_instance" "redis_cluster" {
  vpc_id             = var.app_main_subnet.vpc_id
  subnet_id          = var.app_main_subnet.subnet_id
  availability_zone  = var.app_main_subnet.availability_zone
  type_id            = 16
  password           = "8bXpbPwJJe022" # random_password.password_for_redis.result
  charge_type        = var.charge_type == "PREPAID" ? "PREPAID" : "POSTPAID"
  prepaid_period     = var.charge_prepaid_period
  mem_size           = 8192
  redis_shard_num    = 3
  redis_replicas_num = 1
  name               = "redis"
  port               = 6379
}
