# Command

## Init (AWS)

Start from repository root and create aws.cred files
```sh
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=xxx
```

Source the file
```sh
source aws.cred
```

## Init (GCP)

Start from repository root and create gcp.cred, pointing at a service account key file
```sh
export GOOGLE_APPLICATION_CREDENTIALS=/path/to/your-service-account-key.json
export GOOGLE_PROJECT=your-gcp-project-id
```

Source the file
```sh
source gcp.cred
```

## Create environment

cd to the desired cloud, region and workshop (e.g. AWS ap-northeast-2 k8s, or GCP asia-northeast1 k8s-gcp)
```sh
cd live/aws/ap-northeast-2/k8s
# or
cd live/gcp/asia-northeast1/k8s-gcp
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
