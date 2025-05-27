module "cdn" {
  source = "../../"

  cname = "cdn2.test-yandex.example.ru"
  secondary_hostnames = [    # Дополнительные домены
    "assets.test-yandex.example.ru",
    "static.test-yandex.example.ru"
  ]
  active = true  # CDN активен и доступен клиентам

  # Протокол для origin серверов
  origin_protocol = "http"  # http или https

  # Настройки кэширования
  disable_cache = false
  edge_cache_settings = "86400"      # 24 часа в секундах
  browser_cache_settings = "3600"    # 1 час в секундах
  cache_http_headers = [
    "Content-Type",
    "Cache-Control",
    "ETag"
  ]

  # Параметры запросов
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

  # HTTPS редиректы
  redirect_http_to_https = true
  redirect_https_to_http = false

  # Заголовки
  custom_host_header = "origin.example.com"  # Кастомный Host заголовок для origin
  forward_host_header = false                # Пересылать оригинальный Host заголовок

  # HTTP методы
  allowed_http_methods = ["GET", "HEAD", "POST", "PUT", "DELETE", "OPTIONS"]
  proxy_cache_methods_set = true
  disable_proxy_force_ranges = false

  # Кастомные заголовки
  static_request_headers = {
    "X-Forwarded-Proto" = "https"
    "X-CDN-Provider"    = "yandex"
  }

  static_response_headers = {
    "X-Content-Source" = "yandex-cdn"
    "X-Cache-Status"   = "HIT"
  }

  # Дополнительные настройки
  custom_server_name = "*.example.com"  # Wildcard CNAME
  ignore_cookie = false                 # Учитывать cookies в кэше


  ip_address_acl_policy_type = "allow"  # allow или deny


  origin_group_origins = {
    "main" = {
      enabled = true
      source  = "example.com:80"
      backup  = false
    }
  }
}
