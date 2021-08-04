# Service account to delegate permission for DNS zone via IAM
resource "google_service_account" "delegator" {
  account_id   = local.resource_name
  display_name = "${local.resource_name} service account"
}

resource "google_project_iam_custom_role" "dns-delegator" {
  role_id     = replace("dns_delegator_${local.resource_name}", "-", "_")
  title       = "DNS delegator ${local.resource_name}"
  description = "DNS delegator for ${local.resource_name}"
  permissions = ["dns.changes.create", "dns.resourceRecordSets.update", "dns.resourceRecordSets.delete"]
}

resource "google_project_iam_member" "dns-delegator" {
  role   = google_project_iam_custom_role.dns-delegator.id
  member = "serviceAccount:${google_service_account.delegator.email}"
}

resource "google_service_account_key" "delegator" {
  service_account_id = google_service_account.delegator.name
}