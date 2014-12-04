#!/bin/bash
####################################################
#                Digital Ocean CLI                 #
#           github.com:altoduo/dotfiles            #
####################################################

function usage
{
  echo "help: ./digitalocean.sh [create [-n droplet name] [-r region]] | [-h help]]"
}


if [ -z "$DIGITAL_OCEAN_TOKEN" ]; then
    echo "Need to set Digital Ocean TOKEN as environment variable."
    echo "1) Go to https://cloud.digitalocean.com/settings/applications"
    echo "2) Create a Personal Access Token"
    echo "3) Add 'export DIGITAL_OCEAN_TOKEN=YOUR_ACCESS_TOKEN' to altovars.config"
    exit 1
fi

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  usage
  exit
fi

CREATE=0
REGION=sfo1
NAME=0
DELETE=0
DROPLETID=0

while [[ $# > 1 ]]
  do
  key="$1"
  shift

  case $key in
      create)
                  CREATE=1
                  ;;
      -n|--name)
                  NAME="$1"
                  shift
                  ;;
      -r|--region)
                  REGION="$1"
                  shift
                  ;;
      delete)
                  DELETE=1
                  ;;
      -did| --dropletid)
                  DROPLETID="$1"
                  shift
                  ;;
      #*)
                   #unknown option
      #;;

  esac
done

if [ "$CREATE" -eq 1 ]; then

      if [ "$NAME" = "0" ]; then
      usage
      exit
      fi

      echo "Creating a droplet..."
      echo ""
      echo "Droplet name: $NAME"
      echo "Region: $REGION"
      echo

      curl -X POST -H 'Content-Type: application/json' -H 'Authorization: Bearer '$DIGITAL_OCEAN_TOKEN -d '{"name":"'${NAME}'","region":"'${REGION}'","size":"512mb","image":"ubuntu-14-04-x64","ssh_keys":null,"backups":false,"ipv6":false,"user_data":null,"private_networking":null}' "https://api.digitalocean.com/v2/droplets"

      echo
      echo
      echo "Check your email for IP and login credentials"
      echo
      exit
fi

if [ "$DELETE" -eq 1 ]; then

      if [ "$DROPLETID" = "0" ]; then
      usage
      exit
      fi

      echo "Deleting a droplet..."
      echo ""
      echo "Droplet id: $DROPLETID"
      echo

      curl -X DELETE -H 'Content-Type: application/json' -H 'Authorization: Bearer '$DIGITAL_OCEAN_TOKEN "https://api.digitalocean.com/v2/droplets/${DROPLETID}"

      echo
      echo
      exit
fi


usage
exit
