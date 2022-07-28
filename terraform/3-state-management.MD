# Terraform State

## What is terraform state

What infrastructure it created in _terraform state file_: `terraform.tfstate`.

- Every time you run Terraform, it can fetch the latest status of the infrasture and compare to what is in your configurations to determine what changes need to be applied.

- The output of `plan` command diff between the code on your computer and the infrastructure deployed in the cloud.

- The state file format is for Terraform internal use, to manipulate state should use:
  - `terraform import`
  - `terraform state`


## Shared Storage for State Files

The Terraform state should __NOT__ been shared in a version control.
 
 - :skull: Manual error 

 - :skull: Locking
 
 - :skull: Secrets

 ### Terraform Remote Backend
 
 - Terraform auto store the state file in the backend after each apply;
 - Natively support locking: `terraform apply` will try to acquire a lock;
 - Natively support encryption in transit and encryption at rest of the state file
 
 To enable the remote state storage with S3:
 
 ```tf
 resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state"

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}
 ```
 -1. enable the S3 versioning:
 
 ```tf
 resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}
 ```
 
 -2. enable the encryption:
 
 ```tf
 resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
 ```
 
 -3. block public access:
 
 ```tf
 resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
```

-4. Create a DynamoDB to use for locking

```tf
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

```

-5. Configure Terraform to store the state in S3 bucket

```tf
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
```

-6. use `terraform init` command, the `init` command is idempotent.

With the backend enabled: Terraform will auto _pull_ the latest state from S3 before running a command, and auto _push_ the lastest state to S3 bucket.

```tf
output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = 
```

## Limitations

1. Two steps process:

  - Write Terraform code to create bucked & DynamoDB and deploy the code with local backend
  - Add a remote backend config to it, then use the newly created S3 bucket and DynamoDB table
 
 2. The `backend` block does not allow you to use any variables or references: all manually copy&paste or _partial configurations_: by extract the repeated backend args into a separate file `backend.hcl` and then `terraform init -backend-config=backend.hcl`

## Isolating State Files

Instead of defining all your env in one single set of Terraform configurations, you want to define each env in a separate set of configurations.

- Isolation via workspaces
- Isloation via file layout

### Isolation via workspaces

To create a new workspace or switch between workspaces, use `terraform workspace` commands.

To show current running workspace `terraform workspace show`

To create a new workspace: `terraform workspace new WORKSPACE_NAME`

To list all workspaces: `terraform workspace list`

To select a worksapce: `terraform workspace select WORKSPaCE_NAME`

**Switching to a different workspace is equivalent to chaning the path where your state file is stored**

Change how the module behaves based on the workspace:

```tf
resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = terraform.workspace == "default" ? "t2.medium" : "t2.micro"
}
```

Drawbacks & Error-Prone:

- All the state files of workspaces are stored in the same backend;
- Workspaces are not visible in code or terminal, until the `terraform workspace` command has been ran

**NOT** suitable mechanism for isolating one environment from another.

*** Isolation via File Layout

- Put the Terraform configuration files for each environment into a separate folder
- Config a different backend for each environment

Recommendation: __Use separate folders for each env and for each component within that env.__

<img src="https://user-images.githubusercontent.com/5281761/181621553-aa0e7c2d-cc8b-4433-926e-cfcfb77ddfdc.png" height="600")
