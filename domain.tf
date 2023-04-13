data "ns_domain" "this" {
  stack_id = data.ns_workspace.this.stack_id
  block_id = data.ns_workspace.this.block_id
}

locals {
  domain_name = data.ns_domain.this.dns_name
}

resource "google_dns_managed_zone" "this" {
  name     = local.block_ref
  dns_name = "${local.domain_name}."
  labels   = { for k, v in data.ns_workspace.this.tags : lower(k) => lower(v) }
}
