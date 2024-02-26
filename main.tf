locals {}

resource "yandex_cdn_origin_group" "main" {
  for_each = var.origin_group_origins

  name     = format("%s-%s", var.origin_group_common_name)
  use_next = var.origin_group_use_next

  origin {
    enabled = each.value["enabled"]
    source  = each.value["source"]
    backup  = each.value["backup"]
  }
}

resource "yandex_cdn_resource" "main" {
  cname               = var.cname
  secondary_hostnames = var.secondary_hostnames
  active              = var.active

  # TODO
  folderId = ""
  labels = {}

  options {
    disable_cache          = true
    edge_cache_settings    = 345600
    browser_cache_settings = ""
    cache_http_headers     = ""

    ignore_query_params    = ""
    query_params_whitelist = ""
    query_params_blacklist = ""

    slice                      = ""
    fetched_compressed         = ""
    gzip_on                    = true
    redirect_http_to_https     = true
    redirect_https_to_http     = true
    custom_host_header         = ""
    forward_host_header        = ""
    cors                       = {}
    stale                      = ""
    allowed_http_methods       = ""
    proxy_cache_methods_set    = ""
    disable_proxy_force_ranges = ""
    static_request_headers     = {
      is-from-cdn = "yes"
    }
    static_response_headers = {
      is-cdn = "yes"
    }

    custom_server_name    = ""
    ignore_cookie         = true
    secure_key            = ""
    enable_ip_url_signing = ""
    ip_address_acl {
      excepted_values = ""
      policy_type     = ""
    }


  }

  ssl_certificate {
    type = "lets_encrypt_gcore"
    data {
      cm {
        id = ""
      }
    }
  }


  origin_protocol = "https"

  origin_group_id = yandex_cdn_origin_group.foo_cdn_group_by_id.id
}
