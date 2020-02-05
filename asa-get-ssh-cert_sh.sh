#!/bin/bash
#
# Quick little script to get ASA SSH certificates
# No warranty - Kyle Robinson (kyle.robinson@okta.com)
#


if [ $# -lt 1 ]; then
  echo "Usage: $0 hostname"
  exit 1
fi

asa-get-system(){
    curl -s -X GET \
    https://app.scaleft.com/v1/teams/$asa_team_name/servers\?hostname=$1 \
    -H 'Accept: */*' -H 'Accept-Encoding: gzip, deflate' \
    -H 'Authorization: Bearer '"$asa_bearer_token"'' 
}


asa-get-certs(){
    curl -s -X POST \
    https://app.scaleft.com/v1/teams/$asa_team_name/ssh_connection_info \
    -H 'Accept: */*' -H 'Accept-Encoding: gzip, deflate' \
    -H 'Authorization: Bearer '"$asa_bearer_token"'' \
    -H 'Content-Type: application/json' \
    -d '{
    "targets": [{"id": '\"$asa_system_id\"'}],
    "client_features": ["on-demand"]
    }
    '
}

grep-json(){
    grep -o '"'$1'": "[^"]*' | grep -o '[^"]*$' | grep -v -e '^[[:space:]]*$' | tail -1
}


# Here is where we do the real work.
if sft login >/dev/null; then
    asa_bearer_token=`cat ~/Library/Application\ Support/ScaleFT/state.json | grep-json client_token`
    asa_team_name=`cat ~/Library/Application\ Support/ScaleFT/state.json | grep-json name`
    asa_system_id=`asa-get-system $1 | grep-json id`

    # Do this without the grep to see all the awesome things ASA returns like pub keys,
    # and multiple private keys for bastion hops in more than one project.
    asa-get-certs | grep-json private_key | sed 's/\\n/\
/g'
fi

