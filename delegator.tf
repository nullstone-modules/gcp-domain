# Service account to delegate permission for DNS zone via IAM
locals {
  delegator_name = "${substr(local.block_ref, 0, 30 - length("--12345"))}-${random_string.resource_suffix.result}"
}

resource "google_service_account" "delegator" {
  account_id   = local.delegator_name
  display_name = "${local.resource_name} service account"

  depends_on = [google_project_service.iam]
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

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_member" "dns-delegator" {
  role    = google_project_iam_custom_role.dns-delegator.id
  member  = "serviceAccount:${google_service_account.delegator.email}"
  project = data.google_project.this.project_id
}

locals {
  delegators = toset(concat(var.nullstone_delegators, [local.ns_agent_service_account_email]))
}

// Allow Nullstone Agent(s) to impersonate the delegator account
resource "google_service_account_iam_binding" "delegator_nullstone_agent" {
  service_account_id = google_service_account.delegator.id
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = [for email in local.delegators : "serviceAccount:${email}"]
}

resource "google_service_account_key" "delegator" {
  service_account_id = google_service_account.delegator.name

  count = var.enable_delegator_key ? 1 : 0
}
