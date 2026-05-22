# Project Structure

## Folders

- `modules/` : reusable OpenTofu configuration files  
- `catalog/` : reusable Terragrunt configuration files  
- `catalog/units/` : one unit per module, 1-to-1 mapping with modules/ 
- `catalog/stacks/` : composes a set of units into a workshop environment 
- `live/` : final configurations to apply 
- `live/{region}/` : regional abstraction layer 
- `live/{region}/{workshop}/` : composes a stack for real infrastructure needs 

## Files

- `modules/{name}/main.tf` : module main configuration
- `modules/{name}/variables.tf` : module input variables
- `modules/{name}/version.tf` : provider version constraints
- `catalog/units/{name}/terragrunt.hcl` : defines a unit referencing a module
- `catalog/stacks/{name}/terragrunt.stack.hcl` : defines a stack composing units
- `live/root.hcl` : reusable Terragrunt backend and remote state config
- `live/{region}/region.hcl` : regional variables