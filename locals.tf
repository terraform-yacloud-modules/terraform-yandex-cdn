locals {
  folder_id = coalesce(var.folder_id, data.yandex_client_config.client.folder_id)
  cm_domains         = concat([var.cname], var.secondary_hostnames)
  cm_challenge_count = length(local.cm_domains)
}
