#
# yandex cloud coordinates
#
variable "folder_id" {
  description = <<EOF
    (Optional) The ID of the Yandex Cloud Folder that the resources belongs to.

    Allows to create bucket in different folder.
    It will try to create bucket using IAM-token in provider config, not using access_key.
    If omitted, folder_id specified in provider config and access_key is used.
  EOF
  type        = string
  default     = null
}

#
# common
#
variable "labels" {
  description = "A set of labels that will be applied to all resources in this module."
  type        = map(string)
  default     = {}
}

#
# CDN
#
variable "cname" {
  type        = string
  description = "Primary domain name for content distribution."
}

variable "secondary_hostnames" {
  type        = list(string)
  description = "Additional domain names for content distribution."
  default     = []
}

variable "active" {
  type        = bool
  description = <<EOF
    End user access to content is indicated by the following flag:
    true - indicates that CDN content is available to clients;
    false - indicates that content access is disabled.
  EOF
  default     = true
}

variable "origin_protocol" {
  type        = string
  description = "Origin protocol for sources"
  default     = "http"

  validation {
    condition     = (var.origin_protocol == "http" || var.origin_protocol == "https")
    error_message = "Invalid value for origin_protocol.type. Allowed values are 'http' or 'https'."
  }
}

#
# Options
#
variable "disable_cache" {
  description = "Setup a cache status."
  type        = bool
  default     = false
}

variable "edge_cache_settings" {
  description = <<EOF
    Content will be cached according to origin cache settings.
    The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308
    if an origin server does not have caching HTTP headers.
    Responses with other codes will not be cached.
    The default value is 345600.
  EOF
  type        = string
  default     = "345600"
}

variable "browser_cache_settings" {
  description = <<EOF
    Set up a cache period for the end-users browser.
    Content will be cached due to origin settings.
    If there are no cache settings on your origin,
    the content will not be cached.
    The list of HTTP response codes that can be cached in browsers:
    200, 201, 204, 206, 301, 302, 303, 304, 307, 308.
    Other response codes will not be cached.
    The default value is 0.
  EOF
  type        = string
  default     = "0"
}

variable "cache_http_headers" {
  description = "List of HTTP headers that must be included in responses to clients."
  type        = list(string)
  default     = []
}

variable "ignore_query_params" {
  description = <<EOF
    Files with different query parameters are cached as objects with the same key
    regardless of the parameter value. Selected by default.
  EOF
  type        = bool
  default     = false
}

variable "query_params_whitelist" {
  description = <<EOF
    Files with the specified query parameters are cached as objects with different keys,
    files with other parameters are cached as objects with the same key.
  EOF
  type        = list(string)
  default     = []
}

variable "query_params_blacklist" {
  description = <<EOF
    Files with the specified query parameters are cached as objects with the same key,
    files with other parameters are cached as objects with different keys.
  EOF
  type        = list(string)
  default     = []
}

variable "slice" {
  description = <<EOF
    Files larger than 10 MB will be requested and cached in parts
    (no larger than 10 MB each part). It reduces time to first byte.
    The origin must support HTTP Range requests.
  EOF
  type        = bool
  default     = false
}

variable "fetched_compressed" {
  description = <<EOF
    Option helps you to reduce the bandwidth between origin and CDN servers.
    Also, content delivery speed becomes higher because of reducing the time
    for compressing files in a CDN.
  EOF
  type        = bool
  default     = false
}

variable "gzip_on" {
  description = <<EOF
    GZip compression at CDN servers reduces file size by 70% and can be as high as 90%.
  EOF
  type        = bool
  default     = true
}

variable "redirect_http_to_https" {
  description = <<EOF
    Parameter for redirecting clients from HTTP to HTTPS;
    possible values: 'true' or 'false'.
    Available when using an SSL certificate, otherwise will be set as false.
  EOF
  type        = bool
  default     = true
}

variable "redirect_https_to_http" {
  description = "Set up a redirect from HTTPS to HTTP."
  type        = bool
  default     = false
}

variable "custom_host_header" {
  description = <<EOF
    Custom value for the Host header.
    Your server must be able to process requests with the chosen header.
    E.g.: "ycprojektblue-storage.storage.yandexcloud.net"
  EOF
  type        = string
  default     = null
}

variable "forward_host_header" {
  description = <<EOF
    Choose the Forward Host header option if it is important
    to send in the request to the Origin the same Host header
    as was sent in the request to CDN server.
  EOF
  type        = bool
  default     = true
}

variable "cors" {
  description = <<EOF
    Parameter that lets browsers get access to selected resources
    from a domain different to a domain from which the request is received.
  EOF
  type        = list(string)
  default     = ["*"]
}

variable "allowed_http_methods" {
  description = <<EOF
    HTTP methods for your CDN content.
    By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS.
    In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response.
    If the method is not supported, the user gets the 501 (Not Implemented) response.
  EOF
  type        = list(string)
  default     = ["GET", "HEAD", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"]
}

variable "proxy_cache_methods_set" {
  description = <<EOF
    Allows caching for GET, HEAD and POST requests.
  EOF
  type        = bool
  default     = true
}

variable "disable_proxy_force_ranges" {
  description = "Disabling proxy force ranges."
  type        = bool
  default     = false
}

variable "static_request_headers" {
  description = "Set up custom headers that CDN servers will send in requests to origins."
  type        = map(string)
  default     = {}
}

variable "static_response_headers" {
  description = "Set up custom headers that CDN servers will send in response to clients."
  type        = map(string)
  default     = {}
}

variable "custom_server_name" {
  description = <<EOF
    Wildcard additional CNAME.
    If a resource has a wildcard additional CNAME,
    you can use your own certificate for content delivery via HTTPS.
    Read-only.
  EOF
  type        = string
  default     = null
}

variable "ignore_cookie" {
  description = "Set for ignoring cookie."
  type        = bool
  default     = true
}

variable "secure_key" {
  description = <<EOF
    The secret key. An arbitrary string from 6 to 32 characters long.
    Required to clarify access to a resource using secure tokens
  EOF
  type        = string
  default     = null
}

variable "enable_ip_url_signing" {
  description = <<EOF
    Optional parameter, `true` or `false`.
    It restricts access to a CDN resource based on IP.
    A trusted IP address is specified as a parameter outside a CDN resource when generating an [MD5](https://en.wikipedia.org/wiki/MD5) hash for a signed link.
    If the parameter is not set, file access will be allowed from any IP.
  EOF
  type        = bool
  default     = false
}

variable "ip_address_enabled" {
  description = "If true, IP Address ACL will be enabled"
  type        = bool
  default     = false
}

variable "ip_address_acl_excepted_values" {
  description = <<EOF
    The list of specified IP addresses to be allowed or denied
    depending on acl policy type.
  EOF
  type        = list(string)
  default     = []
}

variable "ip_address_acl_policy_type" {
  description = <<EOF
    The policy type for ip_address_acl option,
    one of "allow" or "deny" values.
  EOF
  type        = string
  default     = "allow"
}


#
# CDN Origin
#

variable "origin_group_use_next" {
  description = <<EOF
    If the option is active (has true value),
    in case the origin responds with 4XX or 5XX codes, use the next origin from the list.
  EOF
  type        = bool
  default     = true
}

variable "origin_group_origins" {
  type = map(object({
    enabled = optional(bool, true)
    source  = string
    backup  = optional(bool, false)
  }))
  default = {}
}

#
# Certificate
#
variable "cdn_ssl_certificate_id" {
  type        = string
  description = "ID of user certificate in Yandex Certificate Manager."
  default     = null
}

variable "cm_issue_ssl_certificate" {
  type        = bool
  description = "If true, Let's Encrypt certificate will be issued for cname"
  default     = false
}

variable "cm_add_challenge_records" {
  description = "If true, Certificate Manager challenge records will be created at dns_zone_id."
  type        = bool
  default     = false
}

#
# DNS
#
variable "dns_zone_id" {
  description = "ID of Yandex DNS zone, where certificate manager records will be created."
  type        = string
  default     = null
}

# TODO: At this moment it's not possible to add it to CloudDNS, because CDN resource does not return endpoint in the format cl-....edgecdn.ru
#variable "dns_create_cname_records" {
#  default = false
#}
#
#variable "dns_create_secondary_records" {
#  default = false
#}
