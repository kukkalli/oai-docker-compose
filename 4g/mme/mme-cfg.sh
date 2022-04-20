#!/bin/bash

INSTANCE=1
PREFIX='/magma-mme/etc'
declare -A MME_CONF

MY_REALM="${REALM}"

echo "HSS IP is: ${HSS_IP}"
echo "MME FQDN is: ${MME_FQDN}"


pushd $PREFIX || exit
MME_CONF[@MME_S6A_IP_ADDR@]="192.168.68.149"
MME_CONF[@INSTANCE@]=$INSTANCE
MME_CONF[@PREFIX@]=$PREFIX
MME_CONF[@REALM@]=$MY_REALM
MME_CONF[@MME_FQDN@]="${MME_FQDN}"
MME_CONF[@HSS_HOSTNAME@]="${HSS_HOSTNAME}"
MME_CONF[@HSS_FQDN@]="${HSS_FQDN}"
MME_CONF[@HSS_IP_ADDR@]="${HSS_IP}"
# MME_CONF[@MCC@]="${MCC}"
# MME_CONF[@MNC@]="${MNC}"
# MME_CONF[@MME_GID@]="${MME_GID}"
# MME_CONF[@MME_CODE@]="${MME_CODE}"
# MME_CONF[@SGWC_IP_ADDRESS@]="${SGWC_IP_ADDRESS}"


cp mme_fd.conf.tmplt $PREFIX/mme_fd.conf

for K in "${!MME_CONF[@]}"; do
  echo "K in mme_fd.conf is $K and value is ${MME_CONF[$K]}"
  egrep -lRZ "$K" $PREFIX/mme_fd.conf | xargs -0 -l sed -i -e "s|$K|${MME_CONF[$K]}|g"
  ret=$?;[[ ret -ne 0 ]] && echo "Tried to replace $K with ${MME_CONF[$K]}"
done

sed -i -e "s@etc/freeDiameter@etc@" /magma-mme/etc/mme_fd.conf
sed -i -e "s@bind: 127.0.0.1@bind: 192.168.61.148@" /etc/magma/redis.yml
# Generate freeDiameter certificate
popd || exit
./check_mme_s6a_certificate $PREFIX "${MME_CONF[@MME_FQDN@]}"

cd /magma-mme || exit
nohup /magma-mme/bin/sctpd > /var/log/sctpd.log 2>&1 &
sleep 5
/magma-mme/bin/oai_mme -c /magma-mme/etc/mme.conf
