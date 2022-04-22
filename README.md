# oai-docker-compose
Docker compose files for OAI Core


## OAI 4G Core
- Clone the EPC FED GitHub Code:
  ```
  git clone git@github.com:kukkalli/openair-epc-fed.git
  cd openair-epc-fed
  git checkout -f v1.2.0
  ```

- Synchronize the git submodules (HSS, SPGW-C and SPGW-U only):
  ```
  cd openair-epc-fed/
  ./scripts/syncComponents.sh
  
  ```

- Clone Magma MME:
  ```
  git clone git@github.com:kukkalli/magma.git
  ```


### Build Docker HSS image:
Build the HSS from :
```
docker build --network=host --target oai-hss --tag oai-hss:production \
               --file component/oai-hss/docker/Dockerfile.ubuntu18.04 \
               # The following line about proxy is certainly not needed in your env \
               --build-arg EURECOM_PROXY="http://proxy.eurecom.fr:8080" \
               component/oai-hss

docker build --network=host --target oai-hss --tag oai-hss:latest \
               --file component/oai-hss/docker/Dockerfile.ubuntu18.04 \
               component/oai-hss

docker image prune --force

docker image ls
```

Check HSS logs
```
docker exec -it oai-hss /bin/bash -c "tail -f /openair-hss/logs/hss.log"
```


### Build Docker Magma MME:
Build the Magma MME from:

Check MME logs
```
docker exec -it magma-mme /bin/bash -c "tail -f /var/log/mme.log"
```


### Build Docker SPGW-C image:
Build the SPGW-C from:
```
docker build --network=host --target oai-spgwc --tag oai-spgwc:latest \
               --file component/oai-spgwc/docker/Dockerfile.ubuntu18.04 \
               # The following line about proxy is certainly not needed in your env \
               --build-arg EURECOM_PROXY="http://proxy.eurecom.fr:8080" \
               component/oai-spgwc

docker build --network=host --target oai-spgwc --tag oai-spgwc:latest \
               --file component/oai-spgwc/docker/Dockerfile.ubuntu18.04 \
               component/oai-spgwc
               
docker build --network=host --target oai-spgwc --tag oai-spgwc:latest --file component/oai-spgwc/docker/Dockerfile.ubuntu18.04 component/oai-spgwc

docker image prune --force

docker image ls

docker login -u kukkalli -p c3360058-8abf-4091-b178-d3d94bc18636
docker image tag oai-spgwc kukkalli/oai-spgwc:latest
docker image tag oai-spgwc kukkalli/oai-spgwc:v1.2.0
docker image push kukkalli/oai-spgwc:latest
docker image push kukkalli/oai-spgwc:v1.2.0
```

Check SPGW-C logs
```
docker exec -it oai-hss /bin/bash -c "tail -f /openair-hss/logs/hss.log"
```



### Build Docker SPGW-U image:
Build the SPGW-U from:
```
docker build --network=host --target oai-spgwu-tiny --tag oai-spgwu-tiny:latest \
               --file component/oai-spgwu-tiny/docker/Dockerfile.ubuntu18.04 \
               # The following line about proxy is certainly not needed in your env \
               --build-arg EURECOM_PROXY="http://proxy.eurecom.fr:8080" \
               component/oai-spgwu-tiny

docker build --network=host --target oai-spgwu-tiny --tag oai-spgwu-tiny:latest \
               --file component/oai-spgwu-tiny/docker/Dockerfile.ubuntu18.04 \
               component/oai-spgwu-tiny

docker build --network=host --target oai-spgwu-tiny --tag oai-spgwu-tiny:latest --file component/oai-spgwu-tiny/docker/Dockerfile.ubuntu18.04 component/oai-spgwu-tiny

docker image prune --force

docker image ls

docker login -u kukkalli -p c3360058-8abf-4091-b178-d3d94bc18636
docker image tag oai-spgwu-tiny kukkalli/oai-spgwu-tiny:latest
docker image tag oai-spgwu-tiny kukkalli/oai-spgwu-tiny:v1.2.0
docker image push kukkalli/oai-spgwu-tiny:latest
docker image push kukkalli/oai-spgwu-tiny:v1.2.0
```
