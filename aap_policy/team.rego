package aap_team

import rego.v1

import data.aap_team_limit
import data.aap_team_vars

# allow if all allow
team_restriction := {
	aap_team_limit.allow,
	aap_team_vars.allow,
}
