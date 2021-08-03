data "ns_domain" "this" {
  stack_id = data.ns_workspace.this.stack_id
  block_id = data.ns_workspace.this.block_id
}

resource "google_dns_managed_zone" "this" {
  name     = data.ns_workspace.this.block_ref
  dns_name = "${data.ns_domain.this.dns_name}."
  labels   = { for k, v in data.ns_workspace.this.tags : lower(k) => lower(v) }
}