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
	check_team_allowed
	violations := [aap_team_limit.violations,aap_team_vars.violations]
	result := {
	    "allowed": false,
	    "violations": [sprintf("Team evaluation failed with the following violations: %v", [violations])],
    }
}

check_team_allowed if {
	resultsarray := [aap_team_limit.allowed,aap_team_vars.allowed]
	some result in resultsarray
	result == false
}
