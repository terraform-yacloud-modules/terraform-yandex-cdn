# TODO: At this moment it's not possible to add it to CloudDNS, because CDN resource does not return endpoint in the format cl-....edgecdn.ru

#resource "yandex_dns_recordset" "cdn_cname" {
#  count   = var.dns_create_cname_records ? 1 : 0
#  zone_id = var.dns_zone_id
#  name    = var.cname
#  type    = "CNAME"
#  data    = [TODO]
#  ttl     = 60
#}
#
#resource "yandex_dns_recordset" "cdn_secondary" {
#  count   = var.dns_create_cname_records ? 1 : 0
#  zone_id = var.dns_zone_id
#  name    = yandex_cm_certificate.cdn.challenges[count.index].dns_name
#  type    = yandex_cm_certificate.cdn.challenges[count.index].dns_type
#  data    = [yandex_cm_certificate.cdn.challenges[count.index].dns_value]
#  ttl     = 60
#}
