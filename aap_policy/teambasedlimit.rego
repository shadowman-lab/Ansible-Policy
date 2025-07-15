package aap_policy_examples

import rego.v1

# Define allowed values for specific limits based on teams
valid_limit_values_by_team := {
    "Linux": ["tag_RHEL", "os_rhel7_64Guest","os_rhel8_64Guest","os_rhel9_64Guest","os_rhel_8x64"],
    "Windows Team": ["tag_Windows", "os_windows9Server64Guest"],
}

# Default response allowing limits unless violations occur
default team_based_limit_restriction := {
    "allowed": true,
    "violations": [],
}

# Evaluate limits against allowed values considering team memberships
team_based_limit_restriction := result if {
    # Extract extra_vars from input
    input_limit := object.get(input, ["limit"], "")

    # Extract user's team names
    user_teams := {team | team := input.created_by.teams[_].name}

    allowed_vals := allowed_values_for_user_teams(user_teams)

    not allowed_value(input_limit, allowed_vals)

    result := {
    "allowed": false,
    "violations": [sprintf("limit contains disallowed values: %v. Allowed limits for your teams (%v): %v", [input_limit, user_teams, allowed_vals])],
    }
}

# Retrieve all allowed values based on user's teams
allowed_values_for_user_teams(teams) := team_values if {
    team_values := {val | team := teams[_]; val := valid_limit_values_by_team[team][_]}
}

# Check if given value is in allowed values set
allowed_value(value, allowed_values) if {
    contains(allowed_values, value)
}
