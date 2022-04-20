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
docker build --target oai-hss --tag oai-hss:production \
               --file component/oai-hss/docker/Dockerfile.ubuntu18.04 \
               # The following line about proxy is certainly not needed in your env \
               --build-arg EURECOM_PROXY="http://proxy.eurecom.fr:8080" \
               component/oai-hss

docker build --target oai-hss --tag oai-hss:latest \
               --file component/oai-hss/docker/Dockerfile.ubuntu18.04 \
               component/oai-hss

docker image prune --force

docker image ls
```
Check HSS logs
```
docker exec -it magma-mme /bin/bash -c "tail -f /openair-hss/logs/mme.log"
```


### Build Docker Magma MME:
Build the Magma MME from:
```
docker exec -it magma-mme /bin/bash -c "tail -f /var/log/mme.log"
```

