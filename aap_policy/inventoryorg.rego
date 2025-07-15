package aap_policy_examples

import rego.v1

# Default policy response indicating allowed status with no violations
default organization_inventory_validation := {
    "allowed": true,
    "violations": [],
}

# Validate that only "Infrastructure" can use "Shadowman Production"
organization_inventory_validation := result if {
    # Extract values from input
    inventory_name := object.get(input, ["inventory", "name"], "")
    org_name := object.get(input, ["organization", "name"], "")

    # Check if inventory is "Shadowman Production"
    inventory_name == "Shadowman Production"

    # Check if organization is not "Infrastructure"
    org_name != "Infrastructure"

    result := {
        "allowed": false,
        "violations": ["Only the 'Infrastructure' organization should use the 'Shadowman Production' inventory"],
    }
}
