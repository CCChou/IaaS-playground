# CLAUDE.md

This project is aim to manage test environment or workshop using IaC pattern.

## Tech Stack

- OpenTofu : Manage the infrastructure
- Terragrunt : Reduce the duplication of OpenTofu's configuration files

## Command

Dry run
- `terragrunt run --all plan`

Create infrastructure
- `terragrunt run --all apply`

Destroy infrastructure
- `terragrunt run --all destroy`

## Repository structure
- `modules/` reusable opentofu configuration files
- `catalog` reusable terragrunt configuration files
- `catalog/units` resuable unit from modules should mapping to each modules
- `catalog/stacks` resuable stack from a set of units and compose as a workshop environments
- `live/` the place for final configuration to apply
- `live/region` the abstract layer for regional management
- `live/region/workshop` the workshop layer for compose stack for real infrastructure needs

## Files description
- `modules/main.tf` define the modules main configs
- `variables.tf` define modules variables
- `version.tf` define provider version
- `root.hcl` define terragrunt reusable backend and state
- `region.hcl`  define regional variables
- `catalog/stacks/terragrunt.stack.hcl` define stack how to compose the units
