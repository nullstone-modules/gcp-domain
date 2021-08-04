output "name" {
  value       = data.ns_domain.this.dns_name
  description = "string ||| The name of the created domain."
}

output "fqdn" {
  value       = data.ns_domain.this.dns_name
  description = "string ||| The FQDN (fully-qualified domain name) for the created domain."
}

output "zone_id" {
  value       = google_dns_managed_zone.this.id
  description = "string ||| Zone id in format projects/{{project}}/managedZones/{{name}}"
}

output "nameservers" {
  value       = google_dns_managed_zone.this.name_servers
  description = "list(string) ||| Delegate your managed_zone to these virtual name servers"
}

output "delegator" {
  value = {
    email = google_service_account.delegator.email
    key_file              = google_service_account_key.delegator.private_key
  }
  description = "object({ email: string, key_file: string }) ||| "

  sensitive = true
}

output "zone_name" {
  value       = data.ns_workspace.this.block_ref
  description = "string ||| The name of the created dns zone."
}