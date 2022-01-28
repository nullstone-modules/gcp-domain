data "google_project" "this" {}

locals {
  project_id     = data.google_project.this.project_id
  project_number = data.google_project.this.number
}

resource "google_project_service" "cloud_resource_manager" {
  project            = local.project_id
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}
