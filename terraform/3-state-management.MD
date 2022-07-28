# Terraform State

## What is terraform state

What infrastructure it created in _terraform state file_: `terraform.tfstate`.

- Every time you run Terraform, it can fetch the latest status of the infrasture and compare to what is in your configurations to determine what changes need to be applied.

- The output of `plan` command diff between the code on your computer and the infrastructure deployed in the cloud.

- The state file format is for Terraform internal use, to manipulate state should use:
  - `terraform import`
  - `terraform state`

- The Terraform state should __NOT__ been shared in a version control.
  - :skull: Manual error
  - :skull: Locking
  - :skull: Secrets

## Shared Storage for State Files

