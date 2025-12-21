# Service account to delegate permission for DNS zone via IAM
resource "google_service_account" "delegator" {
  account_id   = local.resource_name
  display_name = "${local.resource_name} service account"
}

resource "google_project_iam_custom_role" "dns-delegator" {
  role_id     = replace("dns_delegator_${local.resource_name}", "-", "_")
  title       = "DNS delegator ${local.resource_name}"
  description = "DNS delegator for ${local.resource_name}"

  permissions = [
    "dns.changes.create",
    "dns.changes.get",
    "dns.resourceRecordSets.create",
    "dns.resourceRecordSets.delete",
    "dns.resourceRecordSets.get",
    "dns.resourceRecordSets.list",
    "dns.resourceRecordSets.update",
    "dns.managedZones.get",
    "dns.managedZones.list",
  ]
}

resource "google_project_iam_member" "dns-delegator" {
  role    = google_project_iam_custom_role.dns-delegator.id
  member  = "serviceAccount:${google_service_account.delegator.email}"
  project = data.google_project.this.project_id
}

// TODO: Figure out how to remove use of keys
resource "google_service_account_key" "delegator" {
  service_account_id = google_service_account.delegator.name
}

// Allow Nullstone Agent to impersonate the pusher account
resource "google_service_account_iam_binding" "delegator_nullstone_agent" {
  service_account_id = google_service_account.delegator.id
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = ["serviceAccount:${local.ns_agent_service_account_email}"]
}
