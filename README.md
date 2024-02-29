# Yandex Cloud <RESOURCE> Terraform module




Terraform module which creates Yandex Cloud <RESOURCE> resources.

## Examples

Examples codified under
the [`examples`](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/tree/main/examples) are intended
to give users references for how to use the module(s) as well as testing/validating changes to the source code of the
module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow
maintainers to test your changes and to keep the examples up to date for users. Thank you!

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0, <= 1.5.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_cdn_origin_group.main](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/cdn_origin_group) | resource |
| [yandex_cdn_resource.main](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/cdn_resource) | resource |
| [yandex_cm_certificate.cdn](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/cm_certificate) | resource |
| [yandex_dns_recordset.cdn_cm](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_recordset) | resource |
| [yandex_client_config.client](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_active"></a> [active](#input\_active) | End user access to content is indicated by the following flag:<br>    true - indicates that CDN content is available to clients;<br>    false - indicates that content access is disabled. | `bool` | `true` | no |
| <a name="input_allowed_http_methods"></a> [allowed\_http\_methods](#input\_allowed\_http\_methods) | HTTP methods for your CDN content.<br>    By default the following methods are allowed: GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS.<br>    In case some methods are not allowed to the user, they will get the 405 (Method Not Allowed) response.<br>    If the method is not supported, the user gets the 501 (Not Implemented) response. | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD",<br>  "POST",<br>  "PUT",<br>  "PATCH",<br>  "DELETE",<br>  "OPTIONS"<br>]</pre> | no |
| <a name="input_browser_cache_settings"></a> [browser\_cache\_settings](#input\_browser\_cache\_settings) | Set up a cache period for the end-users browser.<br>    Content will be cached due to origin settings.<br>    If there are no cache settings on your origin,<br>    the content will not be cached.<br>    The list of HTTP response codes that can be cached in browsers:<br>    200, 201, 204, 206, 301, 302, 303, 304, 307, 308.<br>    Other response codes will not be cached.<br>    The default value is 0. | `string` | `"0"` | no |
| <a name="input_cache_http_headers"></a> [cache\_http\_headers](#input\_cache\_http\_headers) | List of HTTP headers that must be included in responses to clients. | `list(string)` | `[]` | no |
| <a name="input_cdn_ssl_certificate_id"></a> [cdn\_ssl\_certificate\_id](#input\_cdn\_ssl\_certificate\_id) | ID of user certificate in Yandex Certificate Manager. | `string` | `null` | no |
| <a name="input_cm_add_challenge_records"></a> [cm\_add\_challenge\_records](#input\_cm\_add\_challenge\_records) | If true, Certificate Manager challenge records will be created at dns\_zone\_id. | `bool` | `false` | no |
| <a name="input_cm_issue_ssl_certificate"></a> [cm\_issue\_ssl\_certificate](#input\_cm\_issue\_ssl\_certificate) | If true, Let's Encrypt certificate will be issued for cname | `bool` | `false` | no |
| <a name="input_cname"></a> [cname](#input\_cname) | Primary domain name for content distribution. | `string` | n/a | yes |
| <a name="input_cors"></a> [cors](#input\_cors) | Parameter that lets browsers get access to selected resources<br>    from a domain different to a domain from which the request is received. | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_custom_host_header"></a> [custom\_host\_header](#input\_custom\_host\_header) | Custom value for the Host header.<br>    Your server must be able to process requests with the chosen header.<br>    E.g.: "ycprojektblue-storage.storage.yandexcloud.net" | `string` | `null` | no |
| <a name="input_custom_server_name"></a> [custom\_server\_name](#input\_custom\_server\_name) | Wildcard additional CNAME.<br>    If a resource has a wildcard additional CNAME,<br>    you can use your own certificate for content delivery via HTTPS.<br>    Read-only. | `string` | `null` | no |
| <a name="input_disable_cache"></a> [disable\_cache](#input\_disable\_cache) | Setup a cache status. | `bool` | `false` | no |
| <a name="input_disable_proxy_force_ranges"></a> [disable\_proxy\_force\_ranges](#input\_disable\_proxy\_force\_ranges) | Disabling proxy force ranges. | `bool` | `false` | no |
| <a name="input_dns_zone_id"></a> [dns\_zone\_id](#input\_dns\_zone\_id) | ID of Yandex DNS zone, where certificate manager records will be created. | `string` | `null` | no |
| <a name="input_edge_cache_settings"></a> [edge\_cache\_settings](#input\_edge\_cache\_settings) | Content will be cached according to origin cache settings.<br>    The value applies for a response with codes 200, 201, 204, 206, 301, 302, 303, 304, 307, 308<br>    if an origin server does not have caching HTTP headers.<br>    Responses with other codes will not be cached.<br>    The default value is 345600. | `string` | `"345600"` | no |
| <a name="input_enable_ip_url_signing"></a> [enable\_ip\_url\_signing](#input\_enable\_ip\_url\_signing) | Optional parameter, `true` or `false`.<br>    It restricts access to a CDN resource based on IP.<br>    A trusted IP address is specified as a parameter outside a CDN resource when generating an [MD5](https://en.wikipedia.org/wiki/MD5) hash for a signed link.<br>    If the parameter is not set, file access will be allowed from any IP. | `bool` | `false` | no |
| <a name="input_fetched_compressed"></a> [fetched\_compressed](#input\_fetched\_compressed) | Option helps you to reduce the bandwidth between origin and CDN servers.<br>    Also, content delivery speed becomes higher because of reducing the time<br>    for compressing files in a CDN. | `bool` | `false` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | (Optional) The ID of the Yandex Cloud Folder that the resources belongs to.<br><br>    Allows to create bucket in different folder.<br>    It will try to create bucket using IAM-token in provider config, not using access\_key.<br>    If omitted, folder\_id specified in provider config and access\_key is used. | `string` | `null` | no |
| <a name="input_forward_host_header"></a> [forward\_host\_header](#input\_forward\_host\_header) | Choose the Forward Host header option if it is important<br>    to send in the request to the Origin the same Host header<br>    as was sent in the request to CDN server. | `bool` | `true` | no |
| <a name="input_gzip_on"></a> [gzip\_on](#input\_gzip\_on) | GZip compression at CDN servers reduces file size by 70% and can be as high as 90%. | `bool` | `true` | no |
| <a name="input_ignore_cookie"></a> [ignore\_cookie](#input\_ignore\_cookie) | Set for ignoring cookie. | `bool` | `true` | no |
| <a name="input_ignore_query_params"></a> [ignore\_query\_params](#input\_ignore\_query\_params) | Files with different query parameters are cached as objects with the same key<br>    regardless of the parameter value. Selected by default. | `bool` | `false` | no |
| <a name="input_ip_address_acl_excepted_values"></a> [ip\_address\_acl\_excepted\_values](#input\_ip\_address\_acl\_excepted\_values) | The list of specified IP addresses to be allowed or denied<br>    depending on acl policy type. | `list(string)` | `[]` | no |
| <a name="input_ip_address_acl_policy_type"></a> [ip\_address\_acl\_policy\_type](#input\_ip\_address\_acl\_policy\_type) | The policy type for ip\_address\_acl option,<br>    one of "allow" or "deny" values. | `string` | `"allow"` | no |
| <a name="input_ip_address_enabled"></a> [ip\_address\_enabled](#input\_ip\_address\_enabled) | If true, IP Address ACL will be enabled | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of labels that will be applied to all resources in this module. | `map(string)` | `{}` | no |
| <a name="input_origin_group_origins"></a> [origin\_group\_origins](#input\_origin\_group\_origins) | n/a | <pre>map(object({<br>    enabled = optional(bool, true)<br>    source  = string<br>    backup  = optional(bool, false)<br>  }))</pre> | `{}` | no |
| <a name="input_origin_group_use_next"></a> [origin\_group\_use\_next](#input\_origin\_group\_use\_next) | If the option is active (has true value),<br>    in case the origin responds with 4XX or 5XX codes, use the next origin from the list. | `bool` | `true` | no |
| <a name="input_origin_protocol"></a> [origin\_protocol](#input\_origin\_protocol) | Origin protocol for sources | `string` | `"http"` | no |
| <a name="input_proxy_cache_methods_set"></a> [proxy\_cache\_methods\_set](#input\_proxy\_cache\_methods\_set) | Allows caching for GET, HEAD and POST requests. | `bool` | `true` | no |
| <a name="input_query_params_blacklist"></a> [query\_params\_blacklist](#input\_query\_params\_blacklist) | Files with the specified query parameters are cached as objects with the same key,<br>    files with other parameters are cached as objects with different keys. | `list(string)` | `[]` | no |
| <a name="input_query_params_whitelist"></a> [query\_params\_whitelist](#input\_query\_params\_whitelist) | Files with the specified query parameters are cached as objects with different keys,<br>    files with other parameters are cached as objects with the same key. | `list(string)` | `[]` | no |
| <a name="input_redirect_http_to_https"></a> [redirect\_http\_to\_https](#input\_redirect\_http\_to\_https) | Parameter for redirecting clients from HTTP to HTTPS;<br>    possible values: 'true' or 'false'.<br>    Available when using an SSL certificate, otherwise will be set as false. | `bool` | `true` | no |
| <a name="input_redirect_https_to_http"></a> [redirect\_https\_to\_http](#input\_redirect\_https\_to\_http) | Set up a redirect from HTTPS to HTTP. | `bool` | `false` | no |
| <a name="input_secondary_hostnames"></a> [secondary\_hostnames](#input\_secondary\_hostnames) | Additional domain names for content distribution. | `list(string)` | `[]` | no |
| <a name="input_secure_key"></a> [secure\_key](#input\_secure\_key) | The secret key. An arbitrary string from 6 to 32 characters long.<br>    Required to clarify access to a resource using secure tokens | `string` | `null` | no |
| <a name="input_slice"></a> [slice](#input\_slice) | Files larger than 10 MB will be requested and cached in parts<br>    (no larger than 10 MB each part). It reduces time to first byte.<br>    The origin must support HTTP Range requests. | `bool` | `false` | no |
| <a name="input_static_request_headers"></a> [static\_request\_headers](#input\_static\_request\_headers) | Set up custom headers that CDN servers will send in requests to origins. | `map(string)` | `{}` | no |
| <a name="input_static_response_headers"></a> [static\_response\_headers](#input\_static\_response\_headers) | Set up custom headers that CDN servers will send in response to clients. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed.
See [LICENSE](https://github.com/terraform-yacloud-modules/terraform-yandex-module-template/blob/main/LICENSE).
