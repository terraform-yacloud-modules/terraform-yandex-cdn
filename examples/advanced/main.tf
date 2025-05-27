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
  origin_group_origins = {
    "main" = {
      enabled = true
      source  = "example.com:80"
      backup  = false
    }
  }
}
