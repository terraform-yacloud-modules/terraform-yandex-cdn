variable "cdns" {
  default = {
    "example1" = {
      cname                  = "cdn.test-yandex.example.ru"
      secondary_hostnames    = []
      active                 = true
      origin_protocol        = "https"
      disable_cache          = true
      edge_cache_settings    = "0"
      browser_cache_settings = "0"
      cache_http_headers     = []
      ignore_query_params    = false
      query_params_whitelist = []
      query_params_blacklist = []
      slice                  = false
      fetched_compressed     = false
      gzip_on                = true
      redirect_http_to_https = true
      redirect_https_to_http = false
      custom_host_header     = null
      forward_host_header    = false
      cors                   = ["*"]
      allowed_http_methods = [
        "GET", "HEAD", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"
      ]
      proxy_cache_methods_set    = true
      disable_proxy_force_ranges = false
      static_request_headers = {
        is-from-cdn = "yes"
      }
      static_response_headers = {
        is-cdn = "yes"
      }
      custom_server_name             = null
      ignore_cookie                  = false
      secure_key                     = null
      enable_ip_url_signing          = false
      ip_address_enabled             = false
      ip_address_acl_excepted_values = []
      ip_address_acl_policy_type     = "allow"
      origin_group_use_next          = true
      origin_group_origins = {
        "main" = {
          enabled = true
          source  = "example.com:80"
          backup  = false
        }
      }

      cdn_ssl_certificate_id   = null
      cm_issue_ssl_certificate = true
      cm_add_challenge_records = true
      dns_zone_id              = "dns8sr5o47m1hsdfrh69"
    }
  }
}
