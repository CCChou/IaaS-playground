# TODO

[] Study terragrunt dependency and use it to default vpc in stacks (AWS side only -- GCP's gce-instance/gcp-default-network already does this via a `dependency` block, use it as the reference when porting to AWS)
[] Security group variable support for reusable ec2 instance
[] k8s-gcp pilot currently uses T4/L4 (no MIG support); swap to `a2-highgpu-1g` (A100) once DRA mechanism is validated and MIG testing becomes the focus
[] Install/validate the NVIDIA k8s DRA driver on the k8s-gcp pilot now that apply/destroy is confirmed working end-to-end
