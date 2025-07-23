package aap_maintenance

# Define maintenance window in UTC
maintenance_start_hour := 21 # 21:00 UTC (5 PM EDT)

maintenance_end_hour := 12 # 12:00 UTC (8 AM EDT)

# Extract the job creation timestamp (which is in UTC)
created_clock := time.clock(time.parse_rfc3339_ns(input.created)) # returns [hour, minute, second]

created_hour_utc := created_clock[0]

# Check if job was created within the maintenance window (UTC)
is_maintenance_time if {
    created_hour_utc >= maintenance_start_hour # After 21:00 UTC
}

is_maintenance_time if {
    created_hour_utc < maintenance_end_hour # Before 12:00 UTC
}

default maintenance_window := {
    "allowed": true,
    "violations": [],
}

maintenance_window := {
    "allowed": false,
    "violations": [sprintf("No job execution allowed during maintenance window from start hour: %v, to end hour: %v, current time: %v", [maintenance_start_hour, maintenance_end_hour, created_clock])],
} if {
    is_maintenance_time
}
