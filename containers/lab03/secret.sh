#!/bin/bash

db_secret=$1

if [[ -z $db_secret ]]; then
    echo 'please provide a secret after calling this command'
    exit 1
fi

$db_secret_64="$(echo $db_secret | base64)"
echo $db_secret_64

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: dbpass
type: Opaque
data:
  dbpass: ${db_secret_64}
EOF
