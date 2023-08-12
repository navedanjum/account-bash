#!/bin/bash

# Create a new Aion instance
function create_aion_instance {
    local accSid="$1"
    local instanceFriendlyName="$2"

    curl -X POST http://localhost:19792/v1/instances \
        -H "Content-Type: application/json" \
        -H "I-Twilio-Auth-Account: $accSid" \
        -d "{\"friendly_name\": \"$instanceFriendlyName\",\"template_name\":\"aion_prb\",\"template_version\":\"1.0.67\"}"
}

# List all Aion instances for the specified account
function list_aion_instances {
    local accSid="$1"

    curl -X GET http://localhost:19792/v1/instances \
        -H "I-Twilio-Auth-Account: $accSid"
}

# Prompt the user for account SID and instance friendly name
read -p "Enter account SID: " accSid
read -p "Enter instance friendly name: " instanceFriendlyName

# Usage of create_aion_instance
create_aion_instance "$accSid" "$instanceFriendlyName"

# Usage of list_aion_instances
list_aion_instances "$accSid"
