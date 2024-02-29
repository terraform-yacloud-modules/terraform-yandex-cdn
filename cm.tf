locals {
  cm_domains         = concat([var.cname], var.secondary_hostnames)
  cm_challenge_count = length(local.cm_domains)
}

resource "yandex_cm_certificate" "cdn" {
  count = var.cm_issue_ssl_certificate ? 1 : 0

  name    = format("cdn-%s", var.cname)
  domains = local.cm_domains

  folder_id = local.folder_id
  labels    = var.labels

  managed {
    challenge_type  = "DNS_CNAME"
    challenge_count = local.cm_challenge_count
  }
}

resource "yandex_dns_recordset" "cdn_cm" {
  count   = var.cm_add_challenge_records && var.cm_issue_ssl_certificate ? local.cm_challenge_count : 0
  zone_id = var.dns_zone_id
  name    = yandex_cm_certificate.cdn.challenges[count.index].dns_name
  type    = yandex_cm_certificate.cdn.challenges[count.index].dns_type
  data    = [yandex_cm_certificate.cdn.challenges[count.index].dns_value]
  ttl     = 60
}
