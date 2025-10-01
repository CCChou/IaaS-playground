# Red Hat AI Inference Server Workshop

Create a nvidia driver ready EC2 for rhaiis workshop

## Setup

Export credential as environment variable
```shell
export AWS_ACCESS_KEY_ID=[AWS_ACCESS_KEY_ID]
export AWS_SECRET_ACCESS_KEY=[AWS_SECRET_ACCESS_KEY]
```

Check the backend bucket name should mapping the bootstrap
```shell
vim variable.tf
```

Init the terraform environment
```shell
terraform init
```

Apply
```shell
terraform apply --auto-approve
```

Get the FQDN 
```shell
export FQDN=$(terraform show -json|jq -r '.values.root_module.resources[] | select(.type == "aws_instance") | .values.public_dns')
```

SSH to the EC2 host
```shell
ssh ec2-user@$FQDN
```