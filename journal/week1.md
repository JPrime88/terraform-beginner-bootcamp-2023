# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

- The '-var-file' flag is used to pass Input Variable values into Terraform plan and apply commands using a file that contains the values.

### terraform.tfvars

This is the default file to load in terraform variables in bulk

### auto.tfvars

- This is loaded like a terraform.tfvars. This is treated the same as -var-file arguments but are loaded automatically.

### Order of terraform variables

- Terraform uses a specific order of precedence when determining the value of a variable. If the same variable is assigned multiple values, Terraform will use the value of highest precedence, overriding any other values. Below is the precedence order starting from the highest priority to the lowest. LISTED AS FOLLOWS:

    - Environment variables (TF_VAR_variable_name)
    - The terraform.tfvars file
    - The terraform.tfvars.json file
    - Any .auto.tfvars or .auto.tfvars.json files, processed in lexical order of their filenames.
    - Any -var and -var-file options on the command line, in the order they are provided.
    - Variable defaults
