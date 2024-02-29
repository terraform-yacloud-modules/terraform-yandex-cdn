variable "cdns" {
  default = {
    "frontend" = {
      cname               = "cdn.test-yandex.techeventic.ru"
      secondary_hostnames = []
      active              = true
      origin_protocol     = "https"

      ssl_certificate = {
        type                   = "lets_encrypt_gcore"
        certificate_manager_id = null
      }

      disable_cache          = false
      edge_cache_settings    = 345600
      browser_cache_settings = ""
      ### ^ TODO

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
      stale                  = ["error", "updating"]
      allowed_http_methods   = [
        "GET", "HEAD", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"
      ]
      proxy_cache_methods_set    = ["GET", "HEAD", "POST"]
      disable_proxy_force_ranges = false
      static_request_headers     = {
        is-from-cdn = "yes"
      }
      static_response_headers = {
        is-cdn = "yes"
      }
      custom_server_name = null
      ignore_cookie      = true
      secure_key         = null

      # TODO
      enable_ip_url_signing          = false
      ip_address_acl_excepted_values = []
      ip_address_acl_policy_type     = "allow"

      origin_group_common_name = ""
      origin_group_use_next    = ""
      origin_group_origins     = {
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

  folder_id = data.yandex_client_config.client.folder_id

  name        = format("%s-%s", module.naming.common_name, each.key)
  description = each.value["description"]
  labels      = var.labels

  environment         = each.value["environment"]
  service_account_id  = module.iam_accounts[each.key].id
  deletion_protection = each.value["deletion_protection"]
  network_id          = module.network.vpc_id
  security_group_ids  = [
    module.security_groups[replace(format("%s", each.key), "-", "_")].id
  ]

  opensearch_version      = each.value["opensearch_version"]
  generate_admin_password = each.value["generate_admin_password"]
  opensearch_plugins      = each.value["opensearch_plugins"]

  opensearch_nodes = each.value["opensearch_nodes"]
  dashboard_nodes  = each.value["dashboard_nodes"]

  maintenance_window_type = each.value["maintenance_window_type"]
  maintenance_window_hour = each.value["maintenance_window_hour"]
  maintenance_window_day  = each.value["maintenance_window_day"]

  depends_on = [
    module.iam_accounts,
    module.security_groups
  ]
}
