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

output "teams" {
  description = "Teams"
  value = {
    for key, team in launchdarkly_team.teams : key => {
      id   = team.id
      key  = team.key
      name = team.name
    }
  }
}

output "custom_roles" {
  description = "Custom roles"
  value = {
    ld_admins = {
      id   = launchdarkly_custom_role.ld_admins.id
      key  = launchdarkly_custom_role.ld_admins.key
      name = launchdarkly_custom_role.ld_admins.name
    }
    lead_developers = {
      id   = launchdarkly_custom_role.lead_developers.id
      key  = launchdarkly_custom_role.lead_developers.key
      name = launchdarkly_custom_role.lead_developers.name
    }
    developers = {
      id   = launchdarkly_custom_role.developers.id
      key  = launchdarkly_custom_role.developers.key
      name = launchdarkly_custom_role.developers.name
    }
    business_users = {
      id   = launchdarkly_custom_role.business_users.id
      key  = launchdarkly_custom_role.business_users.key
      name = launchdarkly_custom_role.business_users.name
    }
    qa_testers = {
      id   = launchdarkly_custom_role.qa_testers.id
      key  = launchdarkly_custom_role.qa_testers.key
      name = launchdarkly_custom_role.qa_testers.name
    }
  }
}
