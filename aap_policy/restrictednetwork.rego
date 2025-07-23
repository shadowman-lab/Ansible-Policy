package aap_restrictednetwork

import rego.v1

# Define the allowed playbooks for restricted networks
allowed_playbooks_for_restricted_networks := ["linuxpatching.yml", "windows_patching.yml"]

# Define the restricted instance groups
restricted_instance_groups := ["OCP", "mesh"]

# Default policy response indicating allowed status with no violations
default restricted_networks_checks := {
    "allowed": true,
    "violations": [],
}

# Evaluate restricted_networks_checks to check if playbook is allowed on restricted instance groups
restricted_networks_checks := result if {
    # Extract instance group name from input
    instance_group_name := object.get(input, ["instance_group", "name"], "")

    # Extract playbook name from input
    playbook_name := object.get(input, ["playbook"], "")

    # Check if instance group is restricted and playbook is not allowed
    is_restricted_instance_group(instance_group_name)
    not allowed_playbook_for_restricted_network(playbook_name)

    result := {
    "allowed": false,
    "violations": [sprintf("Playbook '%v' is not allowed on restricted instance group '%v'. Allowed playbooks: %v", [playbook_name, instance_group_name, allowed_playbooks_for_restricted_networks])],
    }
}

# Check if a given instance group is restricted
is_restricted_instance_group(instance_group_name) if {
    some restricted_group in restricted_instance_groups
    instance_group_name == restricted_group
}

# Check if a given playbook is allowed on restricted networks
allowed_playbook_for_restricted_network(playbook_name) if {
    some allowed_playbook in allowed_playbooks_for_restricted_networks
    playbook_name == allowed_playbook
}
