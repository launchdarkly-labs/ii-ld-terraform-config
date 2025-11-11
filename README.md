# LaunchDarkly Terraform Management - Interactive Investor

Terraform configuration for managing LaunchDarkly resources for Interactive Investor using an existing project.

## Requirements

- Terraform >= 1.13
- LaunchDarkly Provider 2.26.0-beta.4

## Project Structure

- **Project**: Uses existing LaunchDarkly project (`default`)
- **Views**:
  - Activation (`activation`)
  - Acquisition (`acquisition`)
  - Content and Research (`content-and-research`)
  - Design Architecture and System (`design-architecture-and-system`)
  - Portfolio and Trading (`portfolio-and-trading`)
  - Proposition 2 (`proposition-2`)
  - Servicing 1 (`servicing-1`)
  - Servicing 2 (`servicing-2`)
- **Teams**:
  - Activation (`activation`)
  - Acquisition (`acquisition`)
  - Content and Research (`content-and-research`)
  - Design Architecture and System (`design-architecture-and-system`)
  - Portfolio and Trading (`portfolio-and-trading`)
  - Proposition 2 (`proposition-2`)
  - Servicing 1 (`servicing-1`)
  - Servicing 2 (`servicing-2`)
- **Custom Roles**: Five custom roles with different permission levels

## Custom Roles

### 1. LD Admins (`ld-admins`)
Full administrative access to all LaunchDarkly resources including account settings, integrations, members, and all project resources. Mimics the built-in admin role.

### 2. Lead Developers (`lead-developers`)
- Can manage all flag actions in non-critical environments
- Can submit change requests for critical environments (cannot review/apply them)
- Full access to experiments, metrics, segments, and release pipelines
- Scoped to specific views via role attributes

### 3. Developers (`developers`)
- Can modify flags and segments in non-critical environments only
- View-only access to critical environments (can update flag metadata but not targeting)
- Full access to experiments, metrics, holdouts, and layers in non-critical environments
- No access to release pipelines
- Scoped to specific views via role attributes

### 4. Business Users (`business-users`)
- Read-only access to flags
- Full access to manage experiments, holdouts, layers, metrics, and metric groups in all environments
- Ideal for product managers and business analysts running experiments
- Scoped to specific views via role attributes

### 5. QA Testers (`qa-testers`)
- Can modify flag targeting (toggle flags, update rules, targets, and prerequisites) in non-critical environments for testing purposes
- Scoped to specific views via role attributes

## Design Logic

This configuration implements a two-tier authorization model:

### Custom Roles (Persona-based)
- **Purpose**: Define different permission levels based on job functions
- **Role Attributes**: Reference Views using `$${roleAttribute/viewKeys}` in policy statements
- **Assignment**: Assigned directly to LD Members without specifying role attributes at assignment time
- **Scoping**: All roles (except LD Admins) are scoped to specific views via role attributes

### Teams (Team-based)
- **Purpose**: Organize members by team within the organization
- **Role Attributes**: Each team has `viewKeys` attribute scoped to their specific view
- **Assignment**: Members inherit role attributes from team membership
- **Lifecycle**: Team `member_ids` are ignored by Terraform to allow manual management via LaunchDarkly UI
- **Examples**: Activation team members automatically get `viewKeys = ["activation"]`, Acquisition team members get `viewKeys = ["acquisition"]`, etc.

### Authorization Flow
1. Members are assigned custom roles directly (defining their permission level)
2. Members are added to teams (inheriting team-specific View access)
3. When accessing LaunchDarkly, members' effective permissions are the intersection of their custom role permissions AND their team's view scope
4. This allows different personas (roles) within the same team to have different permission levels while maintaining team-based access boundaries
5. Additionally, if in the future you decide to implement mapping between LD Custom Roles/Teams and IdP Security Groups, this approach allows reducing the number of the security groups that would need to be created

## Files

- `main.tf` - Main configuration
- `variables.tf` - Variable definitions  
- `outputs.tf` - Output definitions
- `terraform.tfvars.example` - Example variables

## Setup

1. Copy the example file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your LaunchDarkly API token and maintainer IDs:
   - `launchdarkly_access_token` - Your LaunchDarkly API access token
   - `view_maintainer_id` - User ID for view maintainer
   - `team_maintainer_id` - User ID for team maintainer

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Configuration

This configuration uses an existing LaunchDarkly project (`default`) and creates:
- **Views**: Eight team-specific views for organizing feature flags (with SDK keys generated)
- **Teams**: Eight teams with team-specific role attributes (`viewKeys`)
- **Custom Roles**: Five custom roles with different permission levels for various team members

## Managing Teams/Squads

### Adding a New Team/Squad

To add a new team/squad, you only need to edit **one place** in `main.tf`:

1. **Locate the `local.teams` map** in `main.tf` (around line 48-83)
2. **Add a new entry** to the map with the following structure:
   ```hcl
   your_team_key = {
     key  = "your-team-key"  # LaunchDarkly resource key (use kebab-case)
     name = "Your Team Name" # Display name shown in LaunchDarkly UI
   }
   ```
3. **Run Terraform**:
   ```bash
   terraform plan  # Preview the changes
   terraform apply # Create the new view and team
   ```

**Example:**
```hcl
locals {
  teams = {
    # ... existing teams ...
    new_team = {
      key  = "new-team"
      name = "New Team"
    }
  }
}
```

The view and team resources will be automatically created from this configuration.

### Modifying an Existing Team/Squad

1. **Locate the team entry** in the `local.teams` map in `main.tf`
2. **Update the `key` or `name` fields** as needed
3. **Run Terraform**:
   ```bash
   terraform plan  # Preview the changes
   terraform apply # Update the resources
   ```

### Removing a Team/Squad

1. **Remove the team entry** from the `local.teams` map in `main.tf`
2. **Run Terraform**:
   ```bash
   terraform plan  # Preview the changes (will show destruction)
   terraform apply # Destroy the view and team
   ```

### Important Notes

- **Only edit the `local.teams` map** - The view and team resources are automatically generated using `for_each` and should not be edited directly
- The map key (e.g., `activation`) is used as the Terraform resource identifier (use `snake_case`)
- The `key` field (e.g., `"activation"`) is used as the LaunchDarkly resource key (use `kebab-case`)
- The `name` field is the display name shown in the LaunchDarkly UI
- After making changes, always run `terraform plan` first to preview what will be created/modified/destroyed

## Notes

- Team membership (`member_ids`) is managed outside of Terraform to allow flexible member management via the LaunchDarkly UI
- All resources are tagged with team-specific and project tags for organization
