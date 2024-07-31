output "cdn_resource_cname" {
  description = "The CNAME of the CDN resource."
  value       = yandex_cdn_resource.main.cname
}

output "cdn_resource_id" {
  description = "The ID of the CDN resource."
  value       = yandex_cdn_resource.main.id
}

output "cdn_origin_group_id" {
  description = "The ID of the CDN origin group."
  value       = yandex_cdn_origin_group.main.id
}

output "cdn_ssl_certificate_id" {
  description = "The ID of the SSL certificate used by the CDN resource."
  value       = var.cm_issue_ssl_certificate ? yandex_cm_certificate.cdn[0].id : var.cdn_ssl_certificate_id
}

output "dns_recordset_ids" {
  description = "The IDs of the DNS recordsets created for the CDN challenges."
  value       = yandex_dns_recordset.cdn_cm[*].id
}
