#!/bin/bash

# Delete an aion instance
function delete_instance() {
    read -p "Enter account SID: " accSid
    read -p "Enter instance SID: " instanceSid

    curl --location --request DELETE "http://localhost:19792/v1/instances/$instanceSid" \
    --header "I-Twilio-Auth-Account: $accSid"
}

# Close an account
function close_account() {
    read -p "Enter account SID: " accSid

    curl --location --request POST "http://localhost:19650/v3/accounts/$accSid/close" \
    --header "Content-Type: application/json" \
    --header "I-Twilio-Originating-Actor-Sid: TA00000000000000000000000000000001" \
    --header "I-Twilio-Originating-Edge: twilio" \
    --header "I-Twilio-Originating-IP-Address: 127.0.0.1" \
    --header "AUTH-BYPASS: true" \
    --data-raw '{
        "reason": "Scripting E2E test account cleanup",
        "fraud": false
    }'
}

# Delete an account
function delete_account() {
    read -p "Enter account SID: " accSid

    curl --location --request POST "http://localhost:19650/v3/accounts/$accSid/delete" \
    --header "Content-Type: application/json" \
    --header "I-Twilio-Originating-Actor-Sid: TA00000000000000000000000000000001" \
    --header "I-Twilio-Originating-Edge: twilio" \
    --header "I-Twilio-Originating-IP-Address: 127.0.0.1" \
    --header "AUTH-BYPASS: true" \
    --data-raw '{
        "reason": "Scripting E2E test account cleanup",
        "fraud": false
    }'
}


# main menu
while true
do
    echo "Select an option:"
    echo "1. Delete an AION instance"
    echo "2. Close an account"
    echo "3. Delete an account"
    echo "4. Quit"

    read choice

    case $choice in
        1) delete_instance ;;
        2) close_account ;;
        3) delete_account ;;
        4) exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac

    echo "Selected operation completed, Please make a new choice"
done
