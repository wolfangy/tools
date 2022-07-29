# Create Reusable Infrastructure

With Terraform, you can put code inside of a _Terraform module_ and reuse that module in multiple places throughout your code.

## Module Basics

Any set of Terraform configuration files in a folder is a module.

If you run `apply` directly on a module it's refered to as a _root module_.

A reusable module is a module can be used within other modules.

![image](https://user-images.githubusercontent.com/5281761/181664812-6a2731ae-8532-461c-9239-9748bbe865c8.png)

`provider` should be configured only in _root module_ and not reusable module.


Using a __module__:

```tf
module "<NAME>" {

  # <SOURCE> is the path where the module can be found
  source = "<SOURCE>"

  # CONFIG consists of arguments that are specific to that module
  [CONFIG ...]
}
```

:bomb: __All the name in the module CANNOT hardcoded__, if the module has been used more than once, then you'll get name conflict errors.
:hammer: Add __configurable inputs__ to the module so that it can behave differently in different env.


## Module inputs

- Create _variables.tf_ inside the module and add variables

```tf
variable "<VARIABLE_NAME>" {
  description = "<DESCRIPTION>"
  type        = string
}
```

- use `var.<VARIABLE_NAME>` instead of hardcoded names.


## Module Locals

The variables in your module to do some intermediary calculation.

Define the _local values_ in a _local_ block:

```tf
locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}
```

to read the value of a local, you need to use a _local_ reference: `local.<Name>`

