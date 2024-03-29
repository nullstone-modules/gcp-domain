output "name" {
  value       = local.domain_dns_name
  description = "string ||| The name of the created domain."
}

output "fqdn" {
  value       = local.domain_fqdn
  description = "string ||| The FQDN (fully-qualified domain name) for the created domain."
}

output "zone_id" {
  value       = google_dns_managed_zone.this.name
  description = "string ||| Google DNS Managed Zone ID."
}

output "nameservers" {
  value       = [for ns in google_dns_managed_zone.this.name_servers : trimsuffix(ns, ".")]
  description = "list(string) ||| Delegate your managed_zone to these virtual name servers"
}

output "delegator" {
  value = {
    email    = google_service_account.delegator.email
    key_file = google_service_account_key.delegator.private_key
  }
  description = "object({ email: string, key_file: string }) ||| "

  sensitive = true
}
