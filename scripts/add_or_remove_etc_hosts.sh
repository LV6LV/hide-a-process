#!/usr/bin/env bash

# This is a simple script to modify /etc/hosts

usage() {
  cat <<EOF
Usage: $(basename "$0") [-h] -a ACTION -i IP_ADDRESS -d DOMAIN_NAME

Options:
  -h    Show this help message
  -a ACTION      add or remove
  -i IP_ADDRESS  IP address of the domain
  -d DOMAIN_NAME domain name to add or remove
EOF
}

add_entry() {
  if ! grep -q "$ip $domain" /etc/hosts; then
    printf "%s %s\n" "$ip" "$domain" >> /etc/hosts
  else
    echo "The entry already exists in /etc/hosts." >&2
  fi
}

remove_entry() {
  if grep -q "$ip $domain" /etc/hosts; then
    sed -i "/$ip $domain/d" /etc/hosts
  else
    echo "The entry does not exist in /etc/hosts." >&2
  fi
}

# Initialize variables
ip=
domain=

# Parse command line arguments
while getopts "h:a:i:d:" opt; do
  case $opt in
    h) usage exit 0;;
    a) action="$OPTARG";;
    i) ip="$OPTARG";;
    d) domain="$OPTARG";;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      exit 1
      ;;
  esac
done

# Check if the required arguments are provided
if [[ -z "$action" || -z "$ip" || -z "$domain" ]]; then
  echo "Missing required arguments" >&2
  usage
  exit 1
fi

# Check the action
case "$action" in
  add) add_entry;;
  remove) remove_entry;;
  *)
    echo "Invalid action: $action" >&2
    usage
    exit 1
    ;;
esac

# Print updated /etc/hosts
echo "Updated /etc/hosts: "
cat /etc/hosts