#!/bin/bash
# Creates a new Twilio account
# User input parametersuserSid and optional friendlyName
# Starts the owl tube render if succeeds then it executes account creation

function create_twilio_account {
  # Take input from user
  read -p "Please enter userSid: " userSid
  read -p "Please enter I-Twilio-Originating-Actor-Sid, I-Twilio-Auth-User and userSid: " authUserSid

  # Prompt user for friendlyName, or set default value
  read -p "Please enter friendlyName (or press Enter to use default value): " friendlyName
  if [ -z "$friendlyName" ]; then
    friendlyName="e2e_cluster__#$(date +%s)#Demo"
  fi

  # Set curl command parameters
  url="http://localhost:17811/v3/accounts/create"
  originatingIp="127.0.0.1"
  originatingEdge="twilio"
  contentType="Content-Type: application/json"

  # JSON data
  jsonData="{\"userSid\": \"$userSid\",\"source\": \"try-twilio\",\"ip\": \"$originatingIp\",\"account\": {\"friendlyName\": \"$friendlyName\"}}"

  # Set curl command headers
  headers=(
    -H "I-Twilio-Originating-IP-Address: $originatingIp"
    -H "I-Twilio-Originating-Actor-Sid: $authUserSid"
    -H "I-Twilio-Originating-Edge: $originatingEdge"
    -H "I-Twilio-Auth-User: $authUserSid"
    -H "$contentType"
  )

  # Execute curl command and output response data
	# Reference Issue with header passing in curl
	# https://stackoverflow.com/questions/51487117/how-to-use-shell-variable-for-headers-of-curl-command

  response=$(curl -sSL -w "\n%{http_code}" -X POST "$url" "${headers[@]}" -d "$jsonData")
  body=$(echo "$response" | head -n 1)
  status=$(echo "$response" | tail -n 1)
  echo "Response Status: $status"
  echo "Response Body: $body"
}

# Call create_twilio_account function when owl tube succeeds
if owl tubes render flex-setup-system --stage-us1; then
  create_twilio_account
fi
