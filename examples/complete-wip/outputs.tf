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
