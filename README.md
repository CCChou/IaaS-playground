# IaaS-playground

Based on AWS and Terraform to build a consistent environment for workshop, demo and etc.

## Structure

- bootstrap/ : Initialize the environment with S3 and DynamoDB for state control 
- workshops/ : Divide into several scenario based workshop

## Init

Export credential as environment variable
```shell
export AWS_ACCESS_KEY_ID=[AWS_ACCESS_KEY_ID]
export AWS_SECRET_ACCESS_KEY=[AWS_SECRET_ACCESS_KEY]
```

First use bootstrap to provision default setup.
```shell
cd bootstrap
```

Modify the bucket name in order to make sure the name is not same as other.
```shell
vim variable.tf
```

Init S3 Bucket and DynamoDB for shared state. 
```shell
terraform init
terraform apply --auto-approve
```

Next choose the workshop and init with the terraform configs.