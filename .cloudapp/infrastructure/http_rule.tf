resource "tencentcloud_clb_listener_rule" "platform_http_rule" {
  clb_id      = tencentcloud_clb_instance.open_clb.id
  listener_id = tencentcloud_clb_listener.http_listener.id
  domain      = var.app_domain_platform.host
  url         = "/"
}

resource "tencentcloud_clb_attachment" "platform_http_attachment" {
  clb_id      = tencentcloud_clb_instance.open_clb.id
  listener_id = tencentcloud_clb_listener.http_listener.id
  rule_id     = tencentcloud_clb_listener_rule.platform_http_rule.id

  targets {
    instance_id = tencentcloud_instance.cvm_app_main.id
    port        = var.app_domain_platform.port
  }

  targets {
    instance_id = tencentcloud_instance.cvm_slave.id
    port        = var.app_domain_platform.port
  }
}

resource "tencentcloud_clb_listener_rule" "store_http_rule" {
  clb_id      = tencentcloud_clb_instance.open_clb.id
  listener_id = tencentcloud_clb_listener.http_listener.id
  domain      = var.app_domain_store.host
  url         = "/"
}

resource "tencentcloud_clb_attachment" "store_http_attachment" {
  clb_id      = tencentcloud_clb_instance.open_clb.id
  listener_id = tencentcloud_clb_listener.http_listener.id
  rule_id     = tencentcloud_clb_listener_rule.store_http_rule.id

  targets {
    instance_id = tencentcloud_instance.cvm_app_main.id
    port        = var.app_domain_store.port
  }

  targets {
    instance_id = tencentcloud_instance.cvm_slave.id
    port        = var.app_domain_store.port
  }
}

# h5
resource "tencentcloud_clb_listener_rule" "h5_http_rule" {
  clb_id      = tencentcloud_clb_instance.open_clb.id
  listener_id = tencentcloud_clb_listener.http_listener.id
  domain      = var.app_domain_h5.host
  url         = "/"
}

resource "tencentcloud_clb_attachment" "h5_http_attachment" {
  clb_id      = tencentcloud_clb_instance.open_clb.id
  listener_id = tencentcloud_clb_listener.http_listener.id
  rule_id     = tencentcloud_clb_listener_rule.h5_http_rule.id

  targets {
    instance_id = tencentcloud_instance.cvm_app_main.id
    port        = var.app_domain_h5.port
  }

  targets {
    instance_id = tencentcloud_instance.cvm_slave.id
    port        = var.app_domain_h5.port
  }
}

# api
resource "tencentcloud_clb_listener_rule" "api_http_rule" {
  clb_id      = tencentcloud_clb_instance.open_clb.id
  listener_id = tencentcloud_clb_listener.http_listener.id
  domain      = var.app_domain_api.host
  url         = "/"
}

resource "tencentcloud_clb_attachment" "api_http_attachment" {
  clb_id      = tencentcloud_clb_instance.open_clb.id
  listener_id = tencentcloud_clb_listener.http_listener.id
  rule_id     = tencentcloud_clb_listener_rule.api_http_rule.id

  targets {
    instance_id = tencentcloud_instance.cvm_app_main.id
    port        = var.app_domain_api.port
  }

  targets {
    instance_id = tencentcloud_instance.cvm_slave.id
    port        = var.app_domain_api.port
  }
}