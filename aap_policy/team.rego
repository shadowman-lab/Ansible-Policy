package aap_team

import rego.v1

import data.aap_team_limit
import data.aap_team_vars

default team_restriction := {
	"allowed": true,
	"violations": [],
}

# allow if all allow
team_restriction := result if {
	violation_combined := array.concat(aap_team_limit.team_based_limit_restriction.violations,aap_team_vars.team_based_extra_vars_restriction.violations)
	check_team_allowed
	result := {
	    "allowed": false,
	    "violations": [sprintf("Team evaluation failed with the following violations: %v", [violation_combined])],
    }
}

check_team_allowed if {
	resultsarray := [aap_team_limit.team_based_limit_restriction.allowed,aap_team_vars.team_based_extra_vars_restriction.allowed]
	some result in resultsarray
	result == false
}
