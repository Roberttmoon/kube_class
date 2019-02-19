#!/bin/bash

db_secret=$(echo $1 | base64)

if [[ -z $db_secret ]]; then
    echo 'please provide a secret after calling this command'
    exit 1
fi

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: dbpass
type: Opaque
data:
  dbpass: ${db_secret}
EOF
