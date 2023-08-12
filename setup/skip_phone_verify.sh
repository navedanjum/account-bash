#!/bin/bash

function add_caller_id() {
    read -p "Enter account SID: " accSid
	curl --location --request POST "http://localhost:18099/v2/accounts/$accSid/caller-ids?phone_number=+12345&friendly_name=12345"

}

# Usage of add_caller_id
add_caller_id
