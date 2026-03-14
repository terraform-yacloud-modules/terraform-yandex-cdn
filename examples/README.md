# Examples

Please note - the examples provided serve two primary means:

1. Show users working examples of the various ways in which the module can be configured and features supported
2. A means of testing/validating module changes

Please do not mistake the examples provided as "best practices". It is up to users to consult the Yandex.Cloud service documentation for best practices, usage recommendations, etc.

- **minimal** — minimal required inputs: `cname` and at least one origin in `origin_group_origins` (see [cdn_origin_group](https://yandex.cloud/ru/docs/terraform/resources/cdn_origin_group)).
- **advanced** — full options including cache-by-response-codes (`edge_cache_settings_codes_*`), multiple origins, shielding, headers, etc. (see [cdn_resource](https://yandex.cloud/ru/docs/terraform/resources/cdn_resource)).
- **complete-wip** — same as advanced with certificate/DNS placeholders.
