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

# Views - used for managing access to feature flags used by the different teams
resource "launchdarkly_view" "acquisition" {
  key         = "acquisition"
  name        = "Acquisition"
  project_key = data.launchdarkly_project.interactive_investor.key
  description = "View for Acquisition feature flags"
  maintainer_id = var.view_maintainer_id
  generate_sdk_keys = true
  tags = ["acquisition"]
}

resource "launchdarkly_view" "activation" {
  key         = "activation"
  name        = "Activation"
  project_key = data.launchdarkly_project.interactive_investor.key
  description = "View for Activation feature flags"
  maintainer_id = var.view_maintainer_id
  generate_sdk_keys = true
  tags = ["activation"]
}

resource "launchdarkly_view" "content_and_research" {
  key         = "content-and-research"
  name        = "Content and Research"
  project_key = data.launchdarkly_project.interactive_investor.key
  description = "View for Content and Research feature flags"
  maintainer_id = var.view_maintainer_id
  generate_sdk_keys = true
  tags = ["content-and-research"]
}

resource "launchdarkly_view" "design_architecture_and_system" {
  key         = "design-architecture-and-system"
  name        = "Design, Architecture and System"
  project_key = data.launchdarkly_project.interactive_investor.key
  description = "View for Design, Architecture and System feature flags"
  maintainer_id = var.view_maintainer_id
  generate_sdk_keys = true
  tags = ["design-architecture-and-system"]
}

resource "launchdarkly_view" "portfolio_and_trading" {
  key         = "portfolio-and-trading" 
  name        = "Portfolio and Trading"
  project_key = data.launchdarkly_project.interactive_investor.key
  description = "View for Portfolio and Trading feature flags"
  maintainer_id = var.view_maintainer_id
  generate_sdk_keys = true
  tags = ["portfolio-and-trading"]
}

resource "launchdarkly_view" "proposition_2" {
  key         = "proposition-2"
  name        = "Proposition 2"
  project_key = data.launchdarkly_project.interactive_investor.key
  description = "View for Proposition 2 feature flags"
  maintainer_id = var.view_maintainer_id
  generate_sdk_keys = true
  tags = ["proposition-2"]
}

resource "launchdarkly_view" "servicing_1" {
  key         = "servicing-1"
  name        = "Servicing 1"
  project_key = data.launchdarkly_project.interactive_investor.key
  description = "View for Servicing 1 feature flags"
  maintainer_id = var.view_maintainer_id
  generate_sdk_keys = true
  tags = ["servicing-1"]
}

resource "launchdarkly_view" "servicing_2" {
  key         = "servicing-2"
  name        = "Servicing 2"
  project_key = data.launchdarkly_project.interactive_investor.key
  description = "View for Servicing 2 feature flags"
  maintainer_id = var.view_maintainer_id
  generate_sdk_keys = true
  tags = ["servicing-2"]
}
# Teams
resource "launchdarkly_team" "acquisition" {
  key         = "ii-acquisition"
  name        = "II: Acquisition"
  description = "Team for Acquisition members with access to Acquisition feature flags"
  maintainers = [var.team_maintainer_id]
  member_ids  = []
  
  role_attributes {
    key    = "viewKeys"
    values = [launchdarkly_view.acquisition.key]
  }
  
  lifecycle {
    ignore_changes = [member_ids]
  }
}

resource "launchdarkly_team" "activation" {
  key         = "ii-activation"
  name        = "II: Activation"
  description = "Team for Activation members with access to Activation feature flags"
  maintainers = [var.team_maintainer_id]
  member_ids  = []
  
  role_attributes {
    key    = "viewKeys"
    values = [launchdarkly_view.activation.key]
  }
  
  lifecycle {
    ignore_changes = [member_ids]
  }
}

resource "launchdarkly_team" "content_and_research" {
  key         = "ii-content-and-research"
  name        = "II: Content and Research"
  description = "Team for Content and Research members with access to Content and Research feature flags"
  maintainers = [var.team_maintainer_id]
  member_ids  = []
  
  role_attributes {
    key    = "viewKeys"
    values = [launchdarkly_view.content_and_research.key]
  }
  
  lifecycle {
    ignore_changes = [member_ids]
  }
}

resource "launchdarkly_team" "design_architecture_and_system" {
  key         = "ii-design-architecture-and-system"
  name        = "II: Design, Architecture and System"
  description = "Team for Design, Architecture and System members with access to Design, Architecture and System feature flags"
  maintainers = [var.team_maintainer_id]
  member_ids  = []
  
  role_attributes {
    key    = "viewKeys"
    values = [launchdarkly_view.design_architecture_and_system.key]
  }
  
  lifecycle {
    ignore_changes = [member_ids]
  }
}

resource "launchdarkly_team" "portfolio_and_trading" {
  key         = "ii-portfolio-and-trading"
  name        = "II: Portfolio and Trading"
  description = "Team for Portfolio and Trading members with access to Portfolio and Trading feature flags"
  maintainers = [var.team_maintainer_id]
  member_ids  = []
  
  role_attributes {
    key    = "viewKeys"
    values = [launchdarkly_view.portfolio_and_trading.key]
  }
  
  lifecycle {
    ignore_changes = [member_ids]
  }
}

resource "launchdarkly_team" "proposition_2" {
  key         = "ii-proposition-2"
  name        = "II: Proposition 2"
  description = "Team for Proposition 2 members with access to Proposition 2 feature flags"
  maintainers = [var.team_maintainer_id]
  member_ids  = []
  
  role_attributes {
    key    = "viewKeys"
    values = [launchdarkly_view.proposition_2.key]
  }
  
  lifecycle {
    ignore_changes = [member_ids]
  }
}

resource "launchdarkly_team" "servicing_1" {
  key         = "ii-servicing-1"
  name        = "II: Servicing 1"
  description = "Team for Servicing 1 members with access to Servicing 1 feature flags"
  maintainers = [var.team_maintainer_id]
  member_ids  = []
  
  role_attributes {
    key    = "viewKeys"
    values = [launchdarkly_view.servicing_1.key]
  }
  
  lifecycle {
    ignore_changes = [member_ids]
  }
}

resource "launchdarkly_team" "servicing_2" {
  key         = "ii-servicing-2"
  name        = "II: Servicing 2"
  description = "Team for Servicing 2 members with access to Servicing 2 feature flags"
  maintainers = [var.team_maintainer_id]
  member_ids  = []
  
  role_attributes {
    key    = "viewKeys"
    values = [launchdarkly_view.servicing_2.key]
  }
  
  lifecycle {
    ignore_changes = [member_ids]
  }
}
# Custom Roles
# LD Admins Role - full access to LaunchDarkly (mimics built-in admin role)
resource "launchdarkly_custom_role" "ii_ld_admins" {
  key         = "ii-ld-admins"
  name        = "II: LD Admins"
  description = "Full administrative access to all LaunchDarkly resources including account settings, integrations, members, and all project resources"
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

# Lead Engineers Role - scoped to specific view(s), can manage flags in non-critical environments, can request changes in critical environments
resource "launchdarkly_custom_role" "ii_lead_developers" {
  key         = "ii-lead-developers"
  name        = "II: Lead developers"
  description = "Can manage all flag actions in non-critical environments and submit change requests for critical environments. Full access to experiments, metrics, segments, and release pipelines. Scoped to specific views via role attributes."
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
    effect      = "deny"
    actions = ["reviewApprovalRequest", "applyApprovalRequest", "bypassRequiredApproval"]
    resources   = ["proj/*:env/*;{critical:true}:flag/*;view:$${roleAttribute/viewKeys}"]
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
resource "launchdarkly_custom_role" "ii_developers" {
  key         = "ii-developers"
  name        = "II: Developers"
  description = "Can modify flags and segments in non-critical environments only. View-only access to critical environments. Full access to experiments, metrics, holdouts, and layers. No access to release pipelines. Scoped to specific views via role attributes."
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
resource "launchdarkly_custom_role" "ii_business_users" {
  key         = "ii-business-users"
  name        = "II: Business Users"
  description = "Read-only access to flags. Full access to manage experiments, holdouts, layers, metrics, and metric groups in all environments. Ideal for product managers and business analysts running experiments."
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
resource "launchdarkly_custom_role" "ii_qa_testers" {
  key         = "ii-qa-testers"
  name        = "II: QA Testers"
  description = "Can modify flag targeting (toggle flags, update rules, targets, and prerequisites) in non-critical environments for testing purposes. Scoped to specific views via role attributes."
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
