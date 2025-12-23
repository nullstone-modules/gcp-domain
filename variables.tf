variable "nullstone_delegators" {
  type        = list(string)
  default     = []
  description = <<EOF
Add the email of each "Nullstone Agent" to this list. (These are listed in "Cloud Accounts" in Nullstone.)
Each "Nullstone Agent" listed will be able to create subdomains off the main domain.
Typically, this is a list of `nullstone@<project-id>.iam.gserviceaccount.com` for each GCP project.
EOF
}

variable "enable_delegator_key" {
  type        = bool
  default     = false
  description = <<EOF
If true, a service account key will be created for the delegator service account.
They keyfile will be added to the `delegator` output object.
EOF
}
