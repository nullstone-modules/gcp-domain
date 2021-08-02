# gcp-domain

Nullstone to create a domain on GCP.

## Overview

This module creates a DNS Zone which follows a contract to administer through Nullstone.
After creating this DNS Zone, users will need to manually connect their domain registration up to this domain name.
Once completed, all DNS records in that zone can be automatically managed through other modules.

## Delegator

Typically, engineering teams will isolate environments into their own GCP projects.
Since a company's root domain is typically in its own GCP project, this requires allocating subdomains across projects.
To improve security and simplify, this module makes use of a limited-permission service account, called a delegator.
This delegator has explicit permission to delegate areas of a domain.

See [github.com/nullstone-modules/gcp-subdomain](github.com/nullstone-modules/gcp-subdomain) to see example usage.
