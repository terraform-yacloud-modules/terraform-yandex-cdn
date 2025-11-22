module "cdn" {
  source = "../../"

  cname = "cdn2.test-yandex.example.ru"
  secondary_hostnames = [
    "assets.test-yandex.example.ru",
    "static.test-yandex.example.ru"
  ]
  active        = true
  provider_type = "ourcdn"
  shielding = "1"

  labels = {
    environment = "production"
    service     = "cdn"
  }

  origin_protocol = "http"

  disable_cache          = false
  edge_cache_settings    = "86400"
  browser_cache_settings = "3600"
  cache_http_headers = [
    "Content-Type",
    "Cache-Control",
    "ETag"
  ]

  ignore_query_params = false
  query_params_whitelist = [
    "utm_source",
    "utm_medium",
    "version"
  ]
  query_params_blacklist = [
    "session_id",
    "user_token"
  ]

  redirect_http_to_https = true
  redirect_https_to_http = false

  custom_host_header  = "origin.example.com"
  forward_host_header = false

  allowed_http_methods       = ["GET", "HEAD", "POST", "PUT", "DELETE", "OPTIONS"]
  proxy_cache_methods_set    = true
  disable_proxy_force_ranges = false

  static_request_headers = {
    "X-Forwarded-Proto" = "https"
    "X-CDN-Provider"    = "yandex"
  }

  static_response_headers = {
    "X-Content-Source" = "yandex-cdn"
    "X-Cache-Status"   = "HIT"
  }

  custom_server_name = "*.example.com"
  ignore_cookie      = false
  rewrite_flag       = "BREAK"
  rewrite_pattern    = "/old/(.*) /new/$1"

  ip_address_acl_policy_type = "allow"

  origin_group_origins = {
    "main" = {
      enabled = true
      source  = "example.com:80"
      backup  = false
    }
    "backup" = {
      source = "backup.example.com:80"
      backup = true
    }
  }

  slice = true
}
