# oneAPI HPC Toolkit docker on ububtu

Jeongnim Kim, DCG/E&G/ECO/NTET, 2019-08-19

Before start, visit these sites and get familiar with oneAPI/Docker.
* https://docs.docker.com/install/linux/docker-ce/ubuntu
* https://gitlab.devtools.intel.com/sip-oneapi/oneapi-containers

## Getting started 

Same as [Docker Desktop for Mac](oneapi_docker_mac.md)

## Using Intel GPU

```
$oneapi=amr-registry.caas.intel.com/oneapi/oneapi:hpc-dev-ubuntu18.04
$docker run --device=/dev/dri  -it "$oneapi"
```
But, does not appear to work yet.
