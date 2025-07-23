package aap_external_inventory

import rego.v1

default external_inventory_allowed_true := {
    "allowed": true,
    "violations": [],
}

external_inventory_allowed_true := {
    "allowed": false,
    "violations": ["Inventory must use an inventory source"],
} if {
    not input.inventory.has_inventory_sources
}
