package aap_branchallowed

import rego.v1

# Define allowed values for project.scm_branch
valid_project_scm_branch_values := ["dev", "test"]

# Default policy response indicating allowed status with no violations
default project_scm_branch_validation := {
    "allowed": true,
    "violations": [],
}

# Evaluate branch_validation to check if project.scm_branch value is allowed
project_scm_branch_validation := result if {
    # Extract project.scm_branch from input
    branch := object.get(input, ["project", "scm_branch"], "")

    # Check if branch value is not in the allowed list
    not allowed_branch(branch)

    result := {
    "allowed": false,
    "violations": [sprintf("Invalid branch: %v. Only named 'dev' or 'test' branches are allowed.", [branch])],
    }
}

# Check if a given branch value is allowed
allowed_branch(branch) if {
    some allowed_value in valid_project_scm_branch_values
    branch == allowed_value
}
