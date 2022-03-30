#!/bin/sh
# wait-for-hss.sh

sudo apt update

sudo apt install -y netcat

set -e
echo "Waiting for HSS to launch on 3868..."
HSS_IP="$1"

while ! nc -z "$HSS_IP" 3868; do
  sleep 10 # wait for 1/10 of the second before check again
done

echo "HSS launched"

