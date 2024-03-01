resource "yandex_cdn_origin_group" "main" {
  name     = replace(var.cname, ".", "-")
  use_next = var.origin_group_use_next

  dynamic "origin" {
    for_each = var.origin_group_origins
    content {
      enabled = origin.value["enabled"]
      source  = origin.value["source"]
      backup  = origin.value["backup"]
    }
  }
}

resource "yandex_cdn_resource" "main" {
  cname               = var.cname
  secondary_hostnames = var.secondary_hostnames
  active              = var.active

  origin_protocol = var.origin_protocol
  origin_group_id = yandex_cdn_origin_group.main.id

  folder_id = local.folder_id

  options {
    disable_cache              = var.disable_cache
    edge_cache_settings        = var.edge_cache_settings > 0 ? var.edge_cache_settings : null
    browser_cache_settings     = var.browser_cache_settings > 0 ? var.browser_cache_settings : null
    cache_http_headers         = var.cache_http_headers
    ignore_query_params        = var.ignore_query_params
    query_params_whitelist     = var.query_params_whitelist
    query_params_blacklist     = var.query_params_blacklist
    slice                      = var.slice
    fetched_compressed         = var.fetched_compressed
    gzip_on                    = var.gzip_on
    redirect_http_to_https     = var.cdn_ssl_certificate_id != null || var.cm_issue_ssl_certificate ? var.redirect_http_to_https : false
    redirect_https_to_http     = var.redirect_https_to_http
    custom_host_header         = var.custom_host_header
    forward_host_header        = var.forward_host_header
    cors                       = var.cors
    allowed_http_methods       = var.allowed_http_methods
    proxy_cache_methods_set    = var.proxy_cache_methods_set
    disable_proxy_force_ranges = var.disable_proxy_force_ranges
    static_request_headers     = var.static_request_headers
    static_response_headers    = var.static_response_headers
    custom_server_name         = var.custom_server_name
    ignore_cookie              = var.ignore_cookie
    secure_key                 = var.secure_key
    enable_ip_url_signing      = var.secure_key != null ? var.enable_ip_url_signing : null

    dynamic "ip_address_acl" {
      for_each = var.ip_address_enabled ? [1] : []
      content {
        excepted_values = var.ip_address_acl_excepted_values
        policy_type     = var.ip_address_acl_policy_type
      }
    }
  }

  ssl_certificate {
    type                   = var.cdn_ssl_certificate_id != null || var.cm_issue_ssl_certificate ? "certificate_manager" : "not_used"
    certificate_manager_id = var.cdn_ssl_certificate_id != null ? var.cdn_ssl_certificate_id : (var.cm_issue_ssl_certificate ? yandex_cm_certificate.cdn[0].id : null)
  }

  depends_on = [
    yandex_cm_certificate.cdn,
    yandex_dns_recordset.cdn_cm
  ]
}
