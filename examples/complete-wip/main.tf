module "cdn" {
  source = "../../"

  cname = "cdn2.test-yandex.example.ru"
  secondary_hostnames = [
    "assets.test-yandex.example.ru",
    "static.test-yandex.example.ru"
  ]
  active        = true
  provider_type = "ourcdn"
  shielding     = "1"

  labels = {
    environment = "production"
    service     = "cdn"
  }

  origin_protocol = "http"

  edge_cache_settings               = "86400"
  browser_cache_settings            = "3600"
  edge_cache_settings_codes_enabled = false
  edge_cache_settings_value         = "345600"
  edge_cache_settings_custom_values = {}

  # Only ONE of ignore_query_params, query_params_whitelist, or query_params_blacklist can be used
  # Using whitelist to cache only specific query parameters as different objects
  query_params_whitelist = [
    "utm_source",
    "utm_medium",
    "version"
  ]
  # query_params_blacklist and ignore_query_params are mutually exclusive with whitelist
  # query_params_blacklist = ["session_id", "user_token"]  # Example: ignore only these params
  # ignore_query_params = true  # Example: ignore all query params
  slice                  = false
  fetched_compressed     = false
  gzip_on                = true
  redirect_http_to_https = true
  redirect_https_to_http = false

  custom_host_header  = "origin.example.com"
  forward_host_header = false
  cors                = ["*"]

  allowed_http_methods = [
    "GET", "HEAD", "PUT", "PATCH", "DELETE", "OPTIONS"
  ]
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
  ignore_cookie         = false
  secure_key            = null
  enable_ip_url_signing = false
  ip_address_enabled    = false

  ip_address_acl_excepted_values = []
  ip_address_acl_policy_type     = "allow"
  origin_group_use_next          = true
  origin_group_origins = {
    main = {
      enabled = true
      source  = "example.com:80"
      backup  = false
    }
    backup = {
      source = "backup.example.com:80"
      backup = true
    }
  }

  cdn_ssl_certificate_id   = null
  cm_issue_ssl_certificate = false
  cm_add_challenge_records = false
  dns_zone_id              = "dns8sr5o47m1hsdfrh69"

}
