#!/bin/bash

# Get account details and return response body with account flags updated
# Updated account flags do the following 2 things
# 1. Make it non-trial account - Remove flag 2
# 2. Enable aion-console-show - Add flag 5454

update_account_flags() {
    read -p "Enter Account SID: " accSid
    response_body=$(curl -sSL --location --request GET "http://localhost:19650/v3/accounts/$accSid/" \
        --header "Content-Type: application/json" \
        --header "I-Twilio-Auth-Account: $accSid" \
        --header "AUTH-BYPASS: true")

    # Replace flags value 2 with 5454 within the flags array
	updated_response_body=$(echo "$response_body" | jq '.flags |= (index(2) as $i | if $i then .[$i] = 5454 else . end)')

    echo $updated_response_body
	echo "************************************"
	echo "Updating Flags remove flag 2 and replace with flag 5454"
	echo "************************************"

	curl --location --request PUT "http://localhost:19650/v3/accounts/$accSid/" \
        --header "i-twilio-auth-account: $accSid" \
        --header "Content-Type: application/json" \
        --data-raw "$(echo $updated_response_body)"
}

# Example usage
update_account_flags

