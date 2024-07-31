output "cdn_resource_cname" {
  description = "The CNAME of the CDN resource."
  value       = module.cdn.cdn_resource_cname
}

output "cdn_resource_id" {
  description = "The ID of the CDN resource."
  value       = module.cdn.cdn_resource_id
}

output "cdn_origin_group_id" {
  description = "The ID of the CDN origin group."
  value       = module.cdn.cdn_origin_group_id
}

output "cdn_ssl_certificate_id" {
  description = "The ID of the SSL certificate used by the CDN resource."
  value       = module.cdn.cdn_ssl_certificate_id
}

output "dns_recordset_ids" {
  description = "The IDs of the DNS recordsets created for the CDN challenges."
  value       = module.cdn.dns_recordset_ids
}
