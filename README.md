# ocp-release-mirror

Code for a simple container mirroring the OpenShift images to a local repository to install OpenShift in restricted networks. [docs.openshift.com](https://docs.openshift.com/container-platform/4.2/installing/installing_restricted_networks/installing-restricted-networks-preparations.html)

The container image can be downloaded at [quay.io/repository/dgo19/ocp-release-mirror](https://quay.io/repository/dgo19/ocp-release-mirror)

## running in podman/docker

```
podman run -e OCP_RELEASE='4.2.4' -e LOCAL_REGISTRY='my-registry.local:5000' -e LOCAL_REPOSITORY='ocp4/openshift4' -e PULL_SECRET='<your_json_pull_secret_here>' quay.io/dgo19/ocp-release-mirror:latest
```

If your registry does not have an official ssl certificate, you have to mount the CA cert into the container:
```
podman run -v /tmp/myca.crt:/etc/ssl/certs/localca.pem -e OCP_RELEASE='4.2.4' -e LOCAL_REGISTRY='my-registry.local:5000' -e LOCAL_REPOSITORY='ocp4/openshift4' -e PULL_SECRET='<your_json_pull_secret_here>' quay.io/dgo19/ocp-release-mirror:latest
```

## License

MIT license. Source code: https://github.com/dgo19/ocp-release-mirror
