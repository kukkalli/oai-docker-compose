#!/bin/sh
# wait-for-mme.sh

sudo apt update

sudo apt install -y netcat

set -e
echo "Waiting for MME to launch on 3870..."
MME_IP="$1"

while ! nc -z "$MME_IP" 3870; do
  echo "MME at IP $MME_IP not connected"
  sleep 0.1 # wait for 1/10 of the second before check again
done

echo "MME launched"

