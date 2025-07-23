package aap_team

import rego.v1

import data.aap_team_limit
import data.aap_team_vars

default team_validation := {
    "allowed": true,
    "violations": [],
}

team_validation := result if {
    aap_team_limit.allow
    aap_team_vars.allow
}
