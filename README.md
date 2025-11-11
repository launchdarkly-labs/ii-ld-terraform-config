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
  - II: Activation (`ii-activation`)
  - II: Acquisition (`ii-acquisition`)
  - II: Content and Research (`ii-content-and-research`)
  - II: Design Architecture and System (`ii-design-architecture-and-system`)
  - II: Portfolio and Trading (`ii-portfolio-and-trading`)
  - II: Proposition 2 (`ii-proposition-2`)
  - II: Servicing 1 (`ii-servicing-1`)
  - II: Servicing 2 (`ii-servicing-2`)
- **Custom Roles**: Five custom roles with different permission levels

## Custom Roles

### 1. II: LD Admins (`ii-ld-admins`)
Full administrative access to all LaunchDarkly resources including account settings, integrations, members, and all project resources. Mimics the built-in admin role.

### 2. II: Lead Developers (`ii-lead-developers`)
- Can manage all flag actions in non-critical environments
- Can submit change requests for critical environments (cannot review/apply them)
- Full access to experiments, metrics, segments, and release pipelines
- Scoped to specific views via role attributes

### 3. II: Developers (`ii-developers`)
- Can modify flags and segments in non-critical environments only
- View-only access to critical environments (can update flag metadata but not targeting)
- Full access to experiments, metrics, holdouts, and layers in non-critical environments
- No access to release pipelines
- Scoped to specific views via role attributes

### 4. II: Business Users (`ii-business-users`)
- Read-only access to flags
- Full access to manage experiments, holdouts, layers, metrics, and metric groups in all environments
- Ideal for product managers and business analysts running experiments
- Scoped to specific views via role attributes

### 5. II: QA Testers (`ii-qa-testers`)
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

## Notes

- Team membership (`member_ids`) is managed outside of Terraform to allow flexible member management via the LaunchDarkly UI
- All resources are tagged with team-specific and project tags for organization
