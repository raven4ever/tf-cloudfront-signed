#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# extract input variables
eval "$(jq -r '@sh "URL=\(.url) KPID=\(.key-pair-id) PK=\(.private-key) ED=\(.end-date)"')"

SIGNED_URL=$(aws cloudfront sign \
    --url $URL \
    --key-pair-id $KPID \
    --private-key $PK \
    --date-less-than $ED)

jq -n --arg url "$SIGNED_URL"
