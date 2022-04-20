#!/bin/bash

INSTANCE=1
PREFIX='/magma-mme/etc'
declare -A MME_CONF

MY_REALM="${REALM}"

echo "My Realm is: ${MY_REALM}"
echo "HSS IP is: ${HSS_IP}"
echo "MME FQDN is: ${MME_FQDN}"


# pushd $PREFIX || exit
MME_CONF[@MME_S6A_IP_ADDR@]="192.168.68.149"
MME_CONF[@INSTANCE@]=$INSTANCE
MME_CONF[@PREFIX@]=$PREFIX
MME_CONF[@REALM@]=$MY_REALM
MME_CONF[@MME_FQDN@]="${MME_FQDN}"
MME_CONF[@HSS_HOSTNAME@]="${HSS_HOSTNAME}"
MME_CONF[@HSS_FQDN@]="${HSS_FQDN}"
MME_CONF[@HSS_IP_ADDR@]="${HSS_IP}"
MME_CONF[@MCC@]="${MCC}"
MME_CONF[@MNC@]="${MNC}"
MME_CONF[@MME_GID@]="${MME_GID}"
MME_CONF[@MME_CODE@]="${MME_CODE}"
MME_CONF[@SGWC_IP_ADDRESS@]="${SGWC_IP_ADDRESS}"

cp mme.conf.tmplt mme.conf

for K in "${!MME_CONF[@]}"; do
  echo "K in mme.conf is $K and value is ${MME_CONF[$K]}"
  egrep -lRZ "$K" mme.conf | xargs -0 -l sed -i -e "s|$K|${MME_CONF[$K]}|g"
  ret=$?;[[ ret -ne 0 ]] && echo "Tried to replace $K with ${MME_CONF[$K]}"
done
