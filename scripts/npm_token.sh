#!/bin/bash

if [[ $1 != "-s" ]]; then
  if [ -z $NPM_REGISTRY ]; then
    echo -e "Registry: \c"
    read NPM_REGISTRY
  fi

  if [ -z $NPM_USER ]; then
    echo -e "Username: \c"
    read NPM_USER
  fi

  if [ -z $NPM_PASS ]; then
    echo -e "Password: \c"
    read -s NPM_PASS
    echo ""
  fi
fi

if [[ -z $NPM_USER || -z $NPM_PASS ]]; then
  echo "Missing username or password" >&2
  exit 1
fi

NPM_ENC=$(echo -n "$NPM_USER:$NPM_PASS" | openssl base64 -A)

RESP=$(curl -s --location -X PUT "$NPM_REGISTRY/-/user/org.couchdb.user:$NPM_USER" \
--header "Authorization: Basic $NPM_ENC" \
--header 'Content-Type: application/json' \
--data-raw "{
    \"name\":  \"$NPM_USER\",
    \"password\": \"$NPM_PASS\",
    \"readonly\": true
  }")

echo $RESP | jq '.token' | tr -d '"'
