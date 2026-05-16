# Project Structure

## Folder
- `modules/` reusable opentofu configuration files
- `catalog` reusable terragrunt configuration files
- `catalog/units` resuable unit from modules should mapping to each modules
- `catalog/stacks` resuable stack from a set of units and compose as a workshop environments
- `live/` the place for final configuration to apply
- `live/region` the abstract layer for regional management
- `live/region/workshop` the workshop layer for compose stack for real infrastructure needs

## Files description
- `modules/name/main.tf` define the modules main configs
- `modules/name/variables.tf` define modules variables
- `modules/name/version.tf` define provider version
- `live/root.hcl` define terragrunt reusable backend and state
- `live/region.hcl`  define regional variables
- `catalog/stacks/name/terragrunt.stack.hcl` define unit to construct stack
- `catalog/units/name/terragrunt.hcl` define module to be unit