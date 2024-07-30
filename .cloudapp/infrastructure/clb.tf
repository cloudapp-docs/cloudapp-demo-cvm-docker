resource "tencentcloud_clb_instance" "open_clb" {
  network_type               = "OPEN"
  security_groups            = [var.app_clb_sg.security_group_id]
  vpc_id                     = var.app_main_subnet.vpc_id
  subnet_id                  = var.app_main_subnet.subnet_id
  internet_bandwidth_max_out = 100
}

resource "tencentcloud_clb_listener" "http_listener" {
  clb_id        = tencentcloud_clb_instance.open_clb.id
  listener_name = "http_listener"
  port          = 80
  protocol      = "HTTP"
}


resource "tencentcloud_clb_listener" "https_listener" {
  clb_id               = tencentcloud_clb_instance.open_clb.id
  listener_name        = "https_listener"
  port                 = 443
  protocol             = "HTTPS"
  certificate_id       = var.app_ssl_certificate.certId
  certificate_ssl_mode = "UNIDIRECTIONAL"
}