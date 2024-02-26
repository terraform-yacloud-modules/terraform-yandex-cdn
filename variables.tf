#
# CDN
#
variable "cname" {
  type        = string
  description = "CDN endpoint CNAME, must be unique among resources"
}

variable "secondary_hostnames" {
  type = list(string)

  default = []
}

variable "active" {
  type        = bool
  description = "Flag to create Resource either in active or disabled state. True - the content from CDN is available to clients"
  default     = true
}

variable "ssl_certificate" {
  default = {
    type = "lets_encrypt_gcore"
  }

  validation {
    condition = (
    var.ssl_certificate["type"] == "lets_encrypt_gcore" ||
    var.ssl_certificate["type"] == "certificate_manager"
    )
    error_message = "Invalid value for ssl_certificate.type. Allowed values are 'lets_encrypt_gcore' or 'certificate_manager'."
  }
}

#
# Options
#
variable "disable_cache" {
  description = <<EOF
    Setup a cache status.
  EOF
  type    = bool
  default = true
}

variable "edge_cache_settings" {
  description = <<EOF
    Content will be cached according to origin cache settings.
    The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308
    if an origin server does not have caching HTTP headers.
    Responses with other codes will not be cached.
  EOF
  type    = number
  default = 0
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
    The default value is 4 days.
  EOF
  type    = string
  default = "4d"
}

variable "cache_http_headers" {
  description = <<EOF
    List of HTTP headers that must be included in responses to clients.
  EOF
  type    = list(string)
  default = []
}

variable "ignore_query_params" {
  description = <<EOF
    Files with different query parameters are cached as objects with the same key
    regardless of the parameter value. Selected by default.
  EOF
  type    = bool
  default = true
}

variable "query_params_whitelist" {
  description = <<EOF
    Files with the specified query parameters are cached as objects with different keys,
    files with other parameters are cached as objects with the same key.
  EOF
  type    = list(string)
  default = []
}

variable "query_params_blacklist" {
  description = <<EOF
    Files with the specified query parameters are cached as objects with the same key,
    files with other parameters are cached as objects with different keys.
  EOF
  type    = list(string)
  default = []
}

variable "slice" {
  description = <<EOF
    Files larger than 10 MB will be requested and cached in parts
    (no larger than 10 MB each part). It reduces time to first byte.
    The origin must support HTTP Range requests.
  EOF
  type    = bool
  default = false
}

variable "fetched_compressed" {
  description = <<EOF
    Option helps you to reduce the bandwidth between origin and CDN servers.
    Also, content delivery speed becomes higher because of reducing the time
    for compressing files in a CDN.
  EOF
  type    = bool
  default = false
}

variable "gzip_on" {
  description = <<EOF
    GZip compression at CDN servers reduces file size by 70% and can be as high as 90%.
  EOF
  type    = bool
  default = true
}

variable "redirect_http_to_https" {
  description = <<EOF
    Set up a redirect from HTTP to HTTPS.
  EOF
  type    = bool
  default = true
}

variable "redirect_https_to_http" {
  description = <<EOF
    Set up a redirect from HTTPS to HTTP.
  EOF
  type    = bool
  default = true
}

variable "custom_host_header" {
  description = <<EOF
    Custom value for the Host header.
    Your server must be able to process requests with the chosen header.
  EOF
  type    = string
  default = ""
}

variable "forward_host_header" {
  description = <<EOF
    Choose the Forward Host header option if it is important
    to send in the request to the Origin the same Host header
    as was sent in the request to CDN server.
  EOF
  type    = bool
  default = false
}

variable "cors" {
  description = <<EOF
    Parameter that lets browsers get access to selected resources
    from a domain different to a domain from which the request is received.
  EOF
  type    = map(string)
  default = {}
}

variable "stale" {
  description = <<EOF
    List of errors which instruct CDN servers to serve stale content to clients.
  EOF
  type    = list(string)
  default = []
}

variable "allowed_http_methods" {
  description = <<EOF
    HTTP methods for your CDN content.
    By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS.
    In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response.
    If the method is not supported, the user gets the 501 (Not Implemented) response.
  EOF
  type    = string
  default = "GET,HEAD,POST,PUT,PATCH,DELETE,OPTIONS"
}

variable "proxy_cache_methods_set" {
  description = <<EOF
    Allows caching for GET, HEAD and POST requests.
  EOF
  type    = string
  default = "GET,HEAD,POST"
}

variable "disable_proxy_force_ranges" {
  description = <<EOF
    Disabling proxy force ranges.
  EOF
  type    = bool
  default = false
}

variable "static_request_headers" {
  description = <<EOF
    Set up custom headers that CDN servers will send in requests to origins.
  EOF
  type    = map(string)
  default = {}
}

variable "static_response_headers" {
  description = <<EOF
    Set up custom headers that CDN servers will send in response to clients.
  EOF
  type    = map(string)
  default = {}
}

variable "custom_server_name" {
  description = <<EOF
    Wildcard additional CNAME.
    If a resource has a wildcard additional CNAME,
    you can use your own certificate for content delivery via HTTPS.
    Read-only.
  EOF
  type    = string
  default = ""
}

variable "ignore_cookie" {
  description = <<EOF
    Set for ignoring cookie.
  EOF
  type    = bool
  default = false
}

variable "secure_key" {
  description = <<EOF
    Set secure key for URL encoding to protect content and limit access
    by IP addresses and time limits.
  EOF
  type    = string
  default = ""
}

variable "enable_ip_url_signing" {
  description = <<EOF
    Enable access limiting by IP addresses.
    This option is available only with setting secure_key.
  EOF
  type    = bool
  default = false
}

variable "ip_address_acl_excepted_values" {
  description = <<EOF
    The list of specified IP addresses to be allowed or denied
    depending on acl policy type.
  EOF
  type    = list(string)
  default = []
}

variable "ip_address_acl_policy_type" {
  description = <<EOF
    The policy type for ip_address_acl option,
    one of "allow" or "deny" values.
  EOF
  type    = string
  default = "allow"
}


#
# CDN Origin
#
variable "origin_group_common_name" {
  default = ""
}
variable "origin_group_use_next" {
  default = true
}

variable "origin_group_origins" {
  type = map(object({
    enabled = optional(bool, true)
    source  = string
    backup  = optional(bool, false)
  }))
  default = {
    "main" = {
      enabled = true
      source  = "myhost:80"
      backup  = false
    }
  }
}
