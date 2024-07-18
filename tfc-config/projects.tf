resource "tfe_project" "ilm_slm_automation" {
  organization = data.tfe_organization.org.name
  name = "ILM-SLM-Automation"
}