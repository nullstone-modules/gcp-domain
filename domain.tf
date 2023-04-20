data "ns_domain" "this" {
  stack_id = data.ns_workspace.this.stack_id
  block_id = data.ns_workspace.this.block_id
}

locals {
  domain_dns_name = data.ns_domain.this.dns_name
  domain_fqdn = "${local.domain_dns_name}."
}

resource "google_dns_managed_zone" "this" {
  name     = local.block_ref
  dns_name = local.domain_fqdn
  labels   = { for k, v in local.tags : lower(k) => lower(v) }
}
