# 云应用系统变量，主要是镜像仓库相关变量，查看系统变量：https://cloud.tencent.com/document/product/1689/90579
variable "cloudapp_repo_server" {}
variable "cloudapp_repo_username" {}
variable "cloudapp_repo_password" {}

# 用户选择的安装目标位置，VPC 和子网，在 package.yaml 中定义了输入组件
variable "app_main_subnet" {
  type = object({
    region    = string
    region_id = string
    vpc = object({
      id         = string
      cidr_block = string
    })
    subnet = object({
      id   = string
      zone = string
    })
  })
}

variable "app_slave_subnet" {
  type = object({
    region    = string
    region_id = string
    vpc = object({
      id         = string
      cidr_block = string
    })
    subnet = object({
      id   = string
      zone = string
    })
  })
}

variable "app_clb_sg" {
  type = object({
    region            = string
    security_group_id = string
  })
}

variable "app_internal_sg" {
  type = object({
    region            = string
    security_group_id = string
  })
}

variable "charge_type" {
  default = "POSTPAID"
}

variable "charge_prepaid_period" {
  default = 1
}

variable "cvm_app_main_image_id" {
  default = "img-7zu0wa5c"
}

variable "cvm_job_main_image_id" {
  default = "img-54sf4xew"
}

variable "cvm_instance_quality" {
  type = object({
    instance_type = string
  })
}


variable "app_ssl_certificate" {
  type = object({
    certId = string
  })
}

# 域名配置
variable "app_domain_platform" {
  type = object({
    host            = string
    port = string
  })

  default = {
    host = "platform.app.com"
    port = "8119"
  }
}

variable "app_domain_store" {
  type = object({
    host            = string
    port = string
  })

  default = {
    host = "admin.app.com"
    port = "8118"
  }
}

variable "app_domain_h5" {
  type = object({
    host            = string
    port = string
  })

  default = {
    host = "h5.app.com"
    port = "8117"
  }
}

variable "app_domain_api" {
  type = object({
    host            = string
    port = string
  })

  default = {
    host = "api.app.com"
    port = "8112"
  }
}