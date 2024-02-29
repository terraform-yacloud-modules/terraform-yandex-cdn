module "cdn" {
  source = "../../"

  cname = "cdn2.test-yandex.example.ru"
  origin_group_origins = {
    "main" = {
      enabled = true
      source  = "example.com:80"
      backup  = false
    }
  }
}
