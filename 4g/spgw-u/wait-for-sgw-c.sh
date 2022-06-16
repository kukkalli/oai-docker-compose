#!/bin/sh
# wait-for-sgw-c.sh

sudo apt update

sudo apt install -y netcat

set -e
echo "Waiting for SPGW-C to launch on 2123..."
SPGWC_IP="$1"

while ! nc -z -u "$SPGWC_IP" 2123; do
  echo "SPGW-C at IP $SPGWC_IP not connected"
  sleep 0.10 # wait for 1/10 of the second before check again
done

echo "SPGW-C launched"

