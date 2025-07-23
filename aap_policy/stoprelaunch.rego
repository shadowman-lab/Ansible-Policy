package aap_relaunch

import rego.v1

default relaunch_allowed_false := {
    "allowed": true,
    "violations": [],
}

relaunch_allowed_false := {
    "allowed": false,
    "violations": ["Relaunching of a job is not allowed"],
} if {
    input.launch_type == "relaunch"
}
