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

## Module Outputs

A module can return values by using _output variables_.

then the returned output variable can be accessed by:

```tf
module.<MOUDULE_NAME>.<OUTPUT_NAME>
```

## Module Gotchas

- File paths
- Inline blocks

### File Paths

:bomb: By default, Terraform interprets the path relative to the current working directory.

To solve the issue: _path reference_ `path.<TYPE>`:

- `path.module` - return the filesystem path of the module where the _expression_ is defined;
- `path.root` = return the filesystem path of the root module;
- `path.cwd` - return the current __working directory__.

### Inline Blocks

```tf
resource "RESOURCE_TYPE" "RESOURCE_NAME" {
  <NAME> {
    [CONFIG...]
  }
}
```

:bomb: __DO NOT__ mix use both the _inline_ blocks and _separate_ blocks


## Module Versioning

As soon as you make a change to the module folder, it will affect all the environments depend on it in next deployment.


:sunflower: A better solution: create __versioned modules__, so you can use one version in staging and a different version in production.

The easiest way to create a versioned module is to put the code for the module in a separate Git repo and to set the source path parameter to that repo's URL.

- modules
- live
  - stage
  - prod
  - global

![image](https://user-images.githubusercontent.com/5281761/181669115-ae5bafce-1a98-4ea3-a987-24436874c14c.png)

:exclamation: Recommend using Git __tags__ as version numbers for modules:

- Branch name are not stable, as when you get latest commit on the branch, which change every time you run the `init` command
- `sha1` hashes are not very human friendly.

