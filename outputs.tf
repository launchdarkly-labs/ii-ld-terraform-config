output "interactive_investor_project" {
  description = "Interactive Investor project details"
  value = {
    id   = data.launchdarkly_project.interactive_investor.id
    key  = data.launchdarkly_project.interactive_investor.key
    name = data.launchdarkly_project.interactive_investor.name
  }
}

# Note: Environments output removed as we're not using them in this configuration

output "views" {
  description = "Views"
  value = {
    activation = {
      id   = launchdarkly_view.activation.id
      key  = launchdarkly_view.activation.key
      name = launchdarkly_view.activation.name
    }
    acquisition = {
      id   = launchdarkly_view.acquisition.id
      key  = launchdarkly_view.acquisition.key
      name = launchdarkly_view.acquisition.name
    }
    content_and_research = {
      id   = launchdarkly_view.content_and_research.id
      key  = launchdarkly_view.content_and_research.key
      name = launchdarkly_view.content_and_research.name
    }
    design_architecture_and_system = {
      id   = launchdarkly_view.design_architecture_and_system.id
      key  = launchdarkly_view.design_architecture_and_system.key
      name = launchdarkly_view.design_architecture_and_system.name
    }
    portfolio_and_trading = {
      id   = launchdarkly_view.portfolio_and_trading.id
      key  = launchdarkly_view.portfolio_and_trading.key
      name = launchdarkly_view.portfolio_and_trading.name
    }
    proposition_2 = {
      id   = launchdarkly_view.proposition_2.id
      key  = launchdarkly_view.proposition_2.key
      name = launchdarkly_view.proposition_2.name
    }
    servicing_1 = {
      id   = launchdarkly_view.servicing_1.id
      key  = launchdarkly_view.servicing_1.key
      name = launchdarkly_view.servicing_1.name
    }
    servicing_2 = {
      id   = launchdarkly_view.servicing_2.id
      key  = launchdarkly_view.servicing_2.key
      name = launchdarkly_view.servicing_2.name
    }
  }
}

output "teams" {
  description = "Teams"
  value = {
    activation = {
      id   = launchdarkly_team.activation.id
      key  = launchdarkly_team.activation.key
      name = launchdarkly_team.activation.name
    }
    acquisition = {
      id   = launchdarkly_team.acquisition.id
      key  = launchdarkly_team.acquisition.key
      name = launchdarkly_team.acquisition.name
    }
    content_and_research = {
      id   = launchdarkly_team.content_and_research.id
      key  = launchdarkly_team.content_and_research.key
      name = launchdarkly_team.content_and_research.name
    }
    design_architecture_and_system = {
      id   = launchdarkly_team.design_architecture_and_system.id
      key  = launchdarkly_team.design_architecture_and_system.key
      name = launchdarkly_team.design_architecture_and_system.name
    }
    portfolio_and_trading = {
      id   = launchdarkly_team.portfolio_and_trading.id
      key  = launchdarkly_team.portfolio_and_trading.key
      name = launchdarkly_team.portfolio_and_trading.name
    }
    proposition_2 = {
      id   = launchdarkly_team.proposition_2.id
      key  = launchdarkly_team.proposition_2.key
      name = launchdarkly_team.proposition_2.name
    }
    servicing_1 = {
      id   = launchdarkly_team.servicing_1.id
      key  = launchdarkly_team.servicing_1.key
      name = launchdarkly_team.servicing_1.name
    }
    servicing_2 = {
      id   = launchdarkly_team.servicing_2.id
      key  = launchdarkly_team.servicing_2.key
      name = launchdarkly_team.servicing_2.name
    }
  }
}

output "custom_roles" {
  description = "Custom roles"
  value = {
    ii_ld_admins = {
      id   = launchdarkly_custom_role.ii_ld_admins.id
      key  = launchdarkly_custom_role.ii_ld_admins.key
      name = launchdarkly_custom_role.ii_ld_admins.name
    }
    ii_lead_developers = {
      id   = launchdarkly_custom_role.ii_lead_developers.id
      key  = launchdarkly_custom_role.ii_lead_developers.key
      name = launchdarkly_custom_role.ii_lead_developers.name
    }
    ii_developers = {
      id   = launchdarkly_custom_role.ii_developers.id
      key  = launchdarkly_custom_role.ii_developers.key
      name = launchdarkly_custom_role.ii_developers.name
    }
    ii_business_users = {
      id   = launchdarkly_custom_role.ii_business_users.id
      key  = launchdarkly_custom_role.ii_business_users.key
      name = launchdarkly_custom_role.ii_business_users.name
    }
    ii_qa_testers = {
      id   = launchdarkly_custom_role.ii_qa_testers.id
      key  = launchdarkly_custom_role.ii_qa_testers.key
      name = launchdarkly_custom_role.ii_qa_testers.name
    }
  }
}
