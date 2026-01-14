# 0.4.2 (Jan 14, 2026)
* Enabled IAM service for the GCP project.

# 0.4.1 (Jan 14, 2026)
* Shortened delegator service account name to max 30 characters.

# 0.4.0 (Dec 23, 2025)
* Allow a user to disable `key_file` and user impersonation instead.
* Added the ability to specify which Nullstone Agents can delegate subdomains.

# 0.3.3 (Dec 20, 2025)
* Added back `key_file` to delegator output until we can figure out impersonation.

# 0.3.2 (Dec 20, 2025)
* Added `project_id` to delegator output.

# 0.3.1 (Dec 20, 2025)
* Removed `sensitive` from delegator output since it no longer contains keyfile.

# 0.3.0 (Dec 20, 2025)
* Use service account impersonation instead of service account keys for DNS delegator.
* Migrated from `terraform` to `tofu`.

# 0.2.0 (Apr 13, 2023)
* Added module manifest.
* Include trailing `.` in FQDN.

# 0.1.0 (Aug 05, 2021)
* Initial release
