# Getting Started with Terraform

## Installation

## Deploy a Single Server

1. Configure the provider(s)

```tf
provider "aws" {
  region = "us-east-2"
}
```

2. Create a resource syntax:

```tf
resource "<PROVIDER>_<TYPE>" "<NAME>" {
  [CONFIG ...]
}
```

3. `terraform init`: to scan the code and download the code for provider

4. `terraform plan`: to sanity check your code

5. `terraform apply`: to actually create the instances

:exclamation: terraform can show you a diff between what's currently deployed and what's in your Terraform code.

### Deploy a web-server

Pass a shell script or cloud-init directive to _User Data_, EC2 instance will execute it during the first boot.

```tf
resource "aws_instance" "example" {
  ami                    = "ami-0fb653ca2d3203ac1"
  instance_type          = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
  }
}
```

- the `<<-EOF` and `EOF` are Terraform's heredoc syntax, allows you to create __multiple__ strings without having to insert `/n`
- The `user_data_replace_on_change` been set to `true`, when the _user_data_ parapmeter changed, terraform will terminate the original instance and launch a new one.
