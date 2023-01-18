#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# extract input variables
eval "$(jq -r '@sh "URL=\(.url) KPID=\(.kpid) PK=\(.privkey) ED=\(.enddate)"')"

SIGNED_URL=$(aws cloudfront sign \
    --url $URL \
    --key-pair-id $KPID \
    --private-key $PK \
    --date-less-than $ED)

jq -n --arg url "$SIGNED_URL"
