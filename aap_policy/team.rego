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
	result := {
	    "allowed": false,
	    "violations": ["All Team Policies did not pass"],
    }
}

check_team_allowed if {
	resultsarray := [aap_team_limit.allow,aap_team_vars.allow]
	some result in resultsarray
	result == false
}
