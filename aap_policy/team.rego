package aap_team

import rego.v1

import data.aap_team_limit
import data.aap_team_vars

# allow if all allow
allow if {
    aap_team_limit.allow
    aap_team_vars.allow
}
