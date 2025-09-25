# Red Hat AI Inference Server Workshop

Create a nvidia driver ready EC2 for rhaiis workshop

## Setup

Export credential as environment variable
```
export AWS_ACCESS_KEY_ID=[AWS_ACCESS_KEY_ID]
export AWS_SECRET_ACCESS_KEY=[AWS_SECRET_ACCESS_KEY]
```

Init the terraform environment
```
terraform init
```

Apply
```
terraform apply
```

Get the FQDN 
```
export FQDN=$(terraform show -json|jq -r '.values.root_module.resources[] | select(.type == "aws_instance") | .values.public_dns')
```

SSH to the EC2 host
```
ssh ec2-user@$FQDN
```