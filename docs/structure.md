# Project Structure

## Folders

- `modules/` : reusable OpenTofu configuration files, one cloud provider's resources per module
- `catalog/` : reusable Terragrunt configuration files  
- `catalog/units/` : one unit per module, 1-to-1 mapping with modules/ 
- `catalog/scripts/{name}/` : cloud-init/startup scripts shared by a stack across cloud providers
- `catalog/stacks/` : composes a set of units into a workshop environment 
- `live/` : final configurations to apply 
- `live/{cloud}/` : cloud provider abstraction layer (e.g. `aws`, `gcp`)
- `live/{cloud}/{region}/` : regional abstraction layer 
- `live/{cloud}/{region}/{workshop}/` : composes a stack for real infrastructure needs 

Modules/units that are specific to a cloud provider are prefixed with that provider
(`aws-ec2-instance`, `aws-default-vpc`, ...) so multiple providers can offer the same
workshop side by side. GCP's modules are named after Google's own resource names
(`gce-instance`, `gcp-default-network`, `gcp-firewall-rule`), which already read as
provider-specific without needing a separate prefix.

## Files

- `modules/{name}/main.tf` : module main configuration
- `modules/{name}/variables.tf` : module input variables
- `modules/{name}/version.tf` : provider version constraints
- `catalog/units/{name}/terragrunt.hcl` : defines a unit referencing a module
- `catalog/scripts/{stack}/{file}` : a script referenced via `file()` from one or more stacks
- `catalog/stacks/{name}/terragrunt.stack.hcl` : defines a stack composing units
- `live/{cloud}/root.hcl` : reusable Terragrunt backend and remote state config for that cloud
- `live/{cloud}/{region}/region.hcl` : regional variables