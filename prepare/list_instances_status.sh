#!/bin/bash

# List aion instances associated with the given account and their status
function list_aion_instances() {
    read -p "Enter Account SID: " accSid

    curlResponse=$(curl -s -X GET "http://localhost:19792/v1/instances" \
        -H "I-Twilio-Auth-Account: $accSid" \
        | jq '.instances[] | {flex_instance_sid: .flex_instance_sid,
		friendly_name: .friendly_name, status: .status,
		template_version: .template_version, template_name: .template_name}')

    echo $curlResponse
}

function display_instances() {
    response=$(list_aion_instances)
    echo "Instances:"
    echo $response | jq .
}

display_instances
