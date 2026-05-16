# Command

## Init

Start from repository root and create aws.cred files
```sh
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=xxx
```

Source the file
```sh
source aws.cred
```

## Create environment

cd to the desire region and workshop (e.g. ap-northeast-2 k8s)
```sh
cd live/ap-northeast-2/k8s
```

Create the infrastructure
```sh
terragrunt run --all apply
```

Optional: If failed because of the bucket not exist use below to create both bucket and environment
```sh
terragrunt run --all apply --backend-bootstrap
```

## Destroy environment

Destroy the infrastructure
```sh
terragrunt run --all destroy
```
