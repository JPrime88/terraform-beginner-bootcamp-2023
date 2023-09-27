# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:
EXTRA NOTE (I originally did the main file vs. the 'terraform refractor cli' branch. So to keep up with everything correctly, I've redone that branch, added this note, then pulled into the main branch on Github!)

This project is going to utilize semantic versioning for it's tagging.
[semver.org](https://semver.org/)

The general format: I need to make sure that I follow everything to the T

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


### Considerations for Linux Distributions

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distribution needs.

[How to Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues, we noticed that bash script steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) Tidy.
- This allows us an easy to debug and execute manually Terraform CLI install.
- This will allow better portability for other projects that ned to install Terraform CLI.


#### Shebang Considerations


A Shebang (pronounced Sha-bang) tells the bash script what program that will interpret the script. eg. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability fr different OS distributions
- will search the user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the bash script, we can the `./` shorthand notation to execute the bash script. 

eg `./bin/install_terraform_cli`

If we are using a script in gitpod.yml, we need to point the script to a program to interpret it.

`source ./bin/install_terraform_cli`

#### Linux Considerations

In order to make our bash scripts executable, we need to change Linux permissions for the file to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

Alternatively:

```sh
chmod 744 u+x ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/workspace-lifecycle

### Working with Env Vars

#### env command

We can list out all of the Environment Variables (Env Vars) using the `env` command.

We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal, we can set using `export HELLO='world'`

In the terminal, we unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```

Within a bash script, we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCode, it will not be aware of env vars that you have set in another window.

If you want Env Vars to persist across all future bash terminals that are open, you need to set env vars in your bash profile. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `gitpod.yml` but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)


[Getting Started Install(AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following command:

AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is successful, you should see a json payload return that looks like this

```json
{
"UserId": "ASDFG6VU6DJAYGSUJKLOP",
"Account": "123456789012",
"Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials from IAM User (AWS) in order to use the AWS CLI. PLEASE make sure to use the 'aws sts get-caller-identity' command listed above to make sure you are using the correct IAM user!

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to API's that will allow you to create resources in Terraform.

- **Modules** are a way to make large amount of Terraform code modular, portable, and sharable.

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

[Terraform Modules](https://registry.terraform.io/browse/modules)

### Terraform Console

We can see a list of all the Terraform commands by simply typing `terraform`


#### Terraform Init

At the start of a new terraform project, we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.

#### Terraform Plan

`terraform plan`
This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`
This will run a plan and pass the changeset to be executed by Terraform. Apply should prompt us to type in yes or no.

If we want to automatically approve an apply, we can provide the auto approve flag eg. `terraform apply --auto-approve`


### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github

### Terraform State Files

`.terraform.tfstate` contains information about the current state of your infrastructure.

This file **should NOT BE COMMITTED** to your VCS.

This file can contain sensitive data.

If you lose this file, you lose knowing the state of your terraform infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`terraform` directory contains binaries of terraform providers.

**SPECIAL NOTE** For good practice, do NOT mess with the 'terraform.tfstate' file.
