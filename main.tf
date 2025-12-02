terraform {
  required_version = ">= 1.13"
  required_providers {
    launchdarkly = {
      source  = "launchdarkly/launchdarkly"
      version = "2.26.0-beta.4"
    }
  }
}

provider "launchdarkly" {
  access_token = var.launchdarkly_access_token
}

# Interactive Investor Project - Using existing default project
data "launchdarkly_project" "interactive_investor" {
  key = "default"
}

# ============================================================================
# TEAMS/SQUADS CONFIGURATION
# ============================================================================
# 
# IMPORTANT: This is the ONLY place you need to edit when adding or modifying teams/squads!
# 
# To add a new team/squad:
#   1. Add a new entry to the `teams` map below with:
#      - A unique key (used as the Terraform resource identifier, use snake_case)
#      - A `key` field (used as the LaunchDarkly resource key, use kebab-case)
#      - A `name` field (the display name shown in LaunchDarkly UI)
#   2. Run `terraform plan` to preview changes
#   3. Run `terraform apply` to create the new view and team
#
# To modify an existing team/squad:
#   1. Update the `key` or `name` fields in the corresponding entry below
#   2. Run `terraform plan` to preview changes
#   3. Run `terraform apply` to update the resources
#
# To remove a team/squad:
#   1. Remove the corresponding entry from the `teams` map below
#   2. Run `terraform plan` to preview changes
#   3. Run `terraform apply` to destroy the view and team
#
# Note: The views and teams resources below are automatically generated from this map.
#       You do NOT need to modify those resources directly.
# ============================================================================

locals {
  teams = {
    activation = {
      key  = "activation"
      name = "Activation"
    }
    acquisition = {
      key  = "acquisition"
      name = "Acquisition"
    }
    content_and_research = {
      key  = "content-and-research"
      name = "Content and Research"
    }
    design_architecture_and_system = {
      key  = "design-architecture-and-system"
      name = "Design, Architecture and System"
    }
    portfolio_and_trading = {
      key  = "portfolio-and-trading"
      name = "Portfolio and Trading"
    }
    proposition_2 = {
      key  = "proposition-2"
      name = "Proposition 2"
    }
    servicing_1 = {
      key  = "servicing-1"
      name = "Servicing 1"
    }
    servicing_2 = {
      key  = "servicing-2"
      name = "Servicing 2"
    }
  }
}

# ============================================================================
# TEAMS & VIEWS ARE AUTOMATICALLY GENERATED - DO NOT EDIT DIRECTLY
# ============================================================================
# The following resources are automatically generated from the `local.teams` map above.
# To add, modify, or remove teams/squads, edit the `local.teams` map instead.
# ============================================================================

# Views - used for managing access to feature flags used by the different teams
# Automatically created for each entry in local.teams
resource "launchdarkly_view" "teams" {
  for_each = local.teams

  key               = each.value.key
  name              = each.value.name
  project_key       = data.launchdarkly_project.interactive_investor.key
  description       = "View for ${each.value.name} feature flags"
  maintainer_id     = var.view_maintainer_id
  generate_sdk_keys = true
  tags              = [each.value.key]
}

# Teams - automatically created for each entry in local.teams
# Each team is linked to its corresponding view via role_attributes
# All teams have the sandbox-writer role assigned by default
resource "launchdarkly_team" "teams" {
  for_each = local.teams

  key              = each.value.key
  name             = each.value.name
  description      = "Team for ${each.value.name} members with access to ${each.value.name} feature flags"
  maintainers      = [var.team_maintainer_id]
  member_ids       = []
  custom_role_keys = [launchdarkly_custom_role.sandbox_writer.key]

  role_attributes {
    key    = "viewKeys"
    values = [launchdarkly_view.teams[each.key].key]
  }

  lifecycle {
    ignore_changes = [member_ids]
  }
}

# ============================================================================
# CUSTOM ROLES DEFINITIONS
# ============================================================================
# The following resources are manually defined custom roles.
# To add, modify, or remove custom roles, edit the resources below.
# ============================================================================

# LD Admins Role - full access to LaunchDarkly (mimics built-in admin role)
resource "launchdarkly_custom_role" "ld_admins" {
  key              = "ld-admins"
  name             = "LD Admins"
  description      = "Full administrative access to all LaunchDarkly resources including account settings, integrations, members, and all project resources"
  base_permissions = "no_access"

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["acct"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["application/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["code-reference-repository/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["domain-verification/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["integration/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["member/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["member/*:token/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["pending-request/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:aiconfig/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:context-kind/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:destination/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:experiment/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:flag/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:holdout/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:segment/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:layer/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:metric/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:metric-group/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:product-analytics-dashboard/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:view/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:release-pipeline/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["relay-proxy-config/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["role/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["service-token/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["team/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["template/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["webhook/*"]
  }
}

# Lead Developers Role - scoped to specific view(s), can manage flags in non-critical environments, can request changes in critical environments
resource "launchdarkly_custom_role" "lead_developers" {
  key              = "lead-developers"
  name             = "Lead Developers"
  description      = "Can manage all flag actions in non-critical environments and submit change requests for critical environments. Full access to experiments, metrics, segments, and release pipelines. Scoped to specific views via role attributes."
  base_permissions = "no_access"

  # View project
  policy_statements {
    effect    = "allow"
    actions   = ["viewProject"]
    resources = ["proj/*"]
  }

  # View and manage views
  policy_statements {
    effect    = "allow"
    actions   = ["viewView", "linkFlagToView", "unlinkFlagFromView", "updateView"]
    resources = ["proj/*:view/$${roleAttribute/viewKeys}"]
  }

  # All flag actions in scoped to views
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:flag/*;view:$${roleAttribute/viewKeys}"]
  }

  # Deny flag actions in critical environments - can't review/apply change approval requests
  policy_statements {
    effect    = "deny"
    actions   = ["reviewApprovalRequest", "applyApprovalRequest", "bypassRequiredApproval"]
    resources = ["proj/*:env/*;{critical:true}:flag/*;view:$${roleAttribute/viewKeys}"]
  }

  # All segment actions
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:segment/*"]
  }

  # Deny review/apply change approval requests for segments in critical environments
  policy_statements {
    effect      = "deny"
    not_actions = ["reviewApprovalRequest", "applyApprovalRequest"]
    resources   = ["proj/*:env/*;{critical:true}:segment/*"]
  }

  # All actions on metrics
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:metric/*"]
  }

  # All actions on metric groups
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:metric-group/*"]
  }

  # All actions on experiments
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:experiment/*"]
  }

  # All actions on experiment holdouts
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:holdout/*"]
  }

  # All actions on experiment layers
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:layer/*"]
  }

  # All actions on release pipelines
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:release-pipeline/*"]
  }

}

# Engineers Role - scoped to specific view(s), can only modify flags in non-critical environments
resource "launchdarkly_custom_role" "developers" {
  key              = "developers"
  name             = "Developers"
  description      = "Can modify flags and segments in non-critical environments only. View-only access to critical environments. Full access to experiments, metrics, holdouts, and layers. No access to release pipelines. Scoped to specific views via role attributes."
  base_permissions = "no_access"

  # View project
  policy_statements {
    effect    = "allow"
    actions   = ["viewProject"]
    resources = ["proj/*"]
  }

  # View and manage views
  policy_statements {
    effect    = "allow"
    actions   = ["viewView", "linkFlagToView", "unlinkFlagFromView"]
    resources = ["proj/*:view/$${roleAttribute/viewKeys}"]
  }

  # Flag actions in non-critical environments only, scoped to views
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*;{critical:false}:flag/*;view:$${roleAttribute/viewKeys}"]
  }

  # Only allow flag actions that don't impact flag evaluations in critical environments
  policy_statements {
    effect    = "allow"
    actions   = ["createFlag", "addReleasePipeline", "removeReleasePipeline", "replaceReleasePipeline", "updateDescription", "updateDeprecated", "updateFlagCustomProperties", "updateFlagDefaultVariations", "updateFlagVariations", "updateGlobalArchived", "updateIncludeInSnippet", "updateName", "updateTags", "updateTemporary"]
    resources = ["proj/*:env/*;{critical:true}:flag/*;view:$${roleAttribute/viewKeys}"]
  }

  # All segment actions in non-critical environments
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*;{critical:false}:segment/*"]
  }

  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:metric/*"]
  }

  # All actions on metric groups
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:metric-group/*"]
  }

  # All actions on experiments in non-critical environments
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*;{critical:false}:experiment/*"]
  }

  # All actions on experiment holdouts in non-critical environments
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*;{critical:false}:holdout/*"]
  }
}

# Business Role - read-only access to flags, can manage experimentation resources
resource "launchdarkly_custom_role" "business_users" {
  key              = "business-users"
  name             = "Business Users"
  description      = "Read-only access to flags. Full access to manage experiments, holdouts, layers, metrics, and metric groups in all environments. Ideal for product managers and business analysts running experiments."
  base_permissions = "no_access"

  # View project
  policy_statements {
    effect    = "allow"
    actions   = ["viewProject"]
    resources = ["proj/*"]
  }

  # View views
  policy_statements {
    effect    = "allow"
    actions   = ["viewView"]
    resources = ["proj/*:view/$${roleAttribute/viewKeys}"]
  }

  # All actions on experiments (both critical and non-critical environments)
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:experiment/*"]
  }

  # All actions on experiment holdouts (both critical and non-critical environments)
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:env/*:holdout/*"]
  }

  # All actions on experiment layers
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:layer/*"]
  }

  # All actions on metrics
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:metric/*"]
  }

  # All actions on metric groups
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/*:metric-group/*"]
  }
}

# QA Testers Role - can modify flag targeting in non-critical environments
resource "launchdarkly_custom_role" "qa_testers" {
  key              = "qa-testers"
  name             = "QA Testers"
  description      = "Can modify flag targeting (toggle flags, update rules, targets, and prerequisites) in non-critical environments for testing purposes. Scoped to specific views via role attributes."
  base_permissions = "no_access"

  # View project
  policy_statements {
    effect    = "allow"
    actions   = ["viewProject"]
    resources = ["proj/*"]
  }

  # View views
  policy_statements {
    effect    = "allow"
    actions   = ["viewView"]
    resources = ["proj/*:view/$${roleAttribute/viewKeys}"]
  }

  # Modify flag targeting in non-critical environments
  policy_statements {
    effect    = "allow"
    actions   = ["updateOn", "updateFallthrough", "updateTargets", "updateRules", "updateOffVariation", "updatePrerequisites"]
    resources = ["proj/*:env/*;{critical:false}:flag/*;view:$${roleAttribute/viewKeys}"]
  }
}

# Sandbox Writer Role - writer-level access to all resources within the 'sandbox' project
resource "launchdarkly_custom_role" "sandbox_writer" {
  key              = "sandbox-writer"
  name             = "Sandbox Writer"
  description      = "Writer-level access to all resources within the 'sandbox' project. Full access to create, update, and delete flags, segments, experiments, metrics, and other resources in the sandbox project."
  base_permissions = "no_access"

  # View sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["viewProject"]
    resources = ["proj/sandbox"]
  }

  # All actions on sandbox project environments
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:env/*"]
  }

  # All actions on flags in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:env/*:flag/*"]
  }

  # All actions on segments in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:env/*:segment/*"]
  }

  # All actions on experiments in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:env/*:experiment/*"]
  }

  # All actions on experiment holdouts in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:env/*:holdout/*"]
  }

  # All actions on experiment layers in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:layer/*"]
  }

  # All actions on metrics in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:metric/*"]
  }

  # All actions on metric groups in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:metric-group/*"]
  }

  # All actions on views in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:view/*"]
  }

  # All actions on release pipelines in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:release-pipeline/*"]
  }

  # All actions on AI configs in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:env/*:aiconfig/*"]
  }

  # All actions on context kinds in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:context-kind/*"]
  }

  # All actions on destinations in sandbox project
  policy_statements {
    effect    = "allow"
    actions   = ["*"]
    resources = ["proj/sandbox:env/*:destination/*"]
  }
}
