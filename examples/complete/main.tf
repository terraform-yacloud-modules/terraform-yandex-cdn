variable "cdns" {
  default = {
    "frontend" = {
      common_name            = "mycdnprefix"
      cname                  = "cdn.test-yandex.techeventic.ru"
      secondary_hostnames    = []
      active                 = true
      origin_protocol        = "https"
      disable_cache          = false
      edge_cache_settings    = "345600"
      browser_cache_settings = "1800"
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
      forward_host_header    = true
      cors                   = ["*"]
      allowed_http_methods   = [
        "GET", "HEAD", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"
      ]
      proxy_cache_methods_set    = true
      disable_proxy_force_ranges = false
      static_request_headers     = {
        is-from-cdn = "yes"
      }
      static_response_headers = {
        is-cdn = "yes"
      }
      custom_server_name             = null
      ignore_cookie                  = true
      secure_key                     = null
      enable_ip_url_signing          = false
      ip_address_acl_excepted_values = []
      ip_address_acl_policy_type     = "allow"
      origin_group_use_next          = true
      origin_group_origins           = {
        "main" = {
          enabled = true
          source  = "myhost:80"
          backup  = false
        }
      }
    }
  }
}


module "cdn" {
  for_each = var.cdns

  source = "../../"

  common_name                    = each.key
  cname                          = each.value["cname"]
  secondary_hostnames            = each.value["secondary_hostnames"]
  active                         = each.value["active"]
  origin_protocol                = each.value["origin_protocol"]
  disable_cache                  = each.value["disable_cache"]
  edge_cache_settings            = each.value["edge_cache_settings"]
  browser_cache_settings         = each.value["browser_cache_settings"]
  cache_http_headers             = each.value["cache_http_headers"]
  ignore_query_params            = each.value["ignore_query_params"]
  query_params_whitelist         = each.value["query_params_whitelist"]
  query_params_blacklist         = each.value["query_params_blacklist"]
  slice                          = each.value["slice"]
  fetched_compressed             = each.value["fetched_compressed"]
  gzip_on                        = each.value["gzip_on"]
  redirect_http_to_https         = each.value["redirect_http_to_https"]
  redirect_https_to_http         = each.value["redirect_https_to_http"]
  custom_host_header             = each.value["custom_host_header"]
  forward_host_header            = each.value["forward_host_header"]
  cors                           = each.value["cors"]
  allowed_http_methods           = each.value["allowed_http_methods"]
  proxy_cache_methods_set        = each.value["proxy_cache_methods_set"]
  disable_proxy_force_ranges     = each.value["disable_proxy_force_ranges"]
  static_request_headers         = each.value["static_request_headers"]
  static_response_headers        = each.value["static_response_headers"]
  custom_server_name             = each.value["custom_server_name"]
  ignore_cookie                  = each.value["ignore_cookie"]
  secure_key                     = each.value["secure_key"]
  enable_ip_url_signing          = each.value["enable_ip_url_signing"]
  ip_address_acl_excepted_values = each.value["ip_address_acl_excepted_values"]
  ip_address_acl_policy_type     = each.value["ip_address_acl_policy_type"]
  origin_group_use_next          = each.value["origin_group_use_next"]
  origin_group_origins           = each.value["origin_group_origins"]
}
