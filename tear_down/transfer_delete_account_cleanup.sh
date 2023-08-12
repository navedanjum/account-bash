#!/bin/bash

# Transfer ownership to graveyard user
function transfer_ownership {
  echo "Enter the account SID: "
  read accSid

  echo "Enter the original owner SID: "
  read originalOwnerSid

  echo "Enter the graveyard user SID: "
  read graveyardUserSid

  curl --location --request PUT "http://127.0.0.1:18021/v2/users/${originalOwnerSid}/accounts/${accSid}/owners" \
  --header "I-Twilio-Originating-Actor-Sid: ${originalOwnerSid}" \
  --header "I-Twilio-Originating-Edge: twilio" \
  --header "I-Twilio-Originating-IP-Address: 127.0.0.1" \
  --header "Content-Type: application/json" \
  --data-raw "{\"newOwnerSid\":\"${graveyardUserSid}\"}"
}

# Delete record from original owner
function delete_record {
  echo "Enter the account SID: "
  read accSid

  echo "Enter the original owner SID: "
  read originalOwnerSid

  echo "Enter the graveyard user SID: "
  read graveyardUserSid

  curl --location --request DELETE "http://127.0.0.1:18021/v2/users/${originalOwnerSid}/accounts/${accSid}" \
  --header "I-Twilio-Originating-Actor-Sid: ${originalOwnerSid}" \
  --header "I-Twilio-Originating-Edge: twilio" \
  --header "I-Twilio-Originating-IP-Address: 127.0.0.1" \
  --header "Content-Type: application/json" \
  --data-raw "{\"newOwnerSid\":\"${graveyardUserSid}\"}"
}

# Main menu
while true; do
  echo "Enter 1 to transfer ownership"
  echo "Enter 2 to delete record from original owner"
  echo "Enter q to quit"

  read choice

  case $choice in
    1) transfer_ownership ;;
    2) delete_record ;;
    q) exit ;;
    *) echo "Invalid choice. Try again." ;;
  esac
done

echo "Done."
