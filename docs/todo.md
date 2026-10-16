# TODO

[] Study terragrunt dependency and use it to default vpc in stacks
[] Security group variable support for reusable ec2 instance
[] Rename AWS modules/units with an `aws-` prefix (`ec2-instance` -> `aws-ec2-instance`, `default-vpc` -> `aws-default-vpc`, `sg` -> `aws-sg`, `sg-rule` -> `aws-sg-rule`) for naming symmetry with the GCP modules
[] k8s-gcp pilot currently uses T4/L4 (no MIG support); swap to `a2-highgpu-1g` (A100) once DRA mechanism is validated and MIG testing becomes the focus
[] Create the `dennis-iaas-gcp-asia-northeast1` GCS bucket (first apply can use `--backend-bootstrap`)
