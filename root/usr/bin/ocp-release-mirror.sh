#!/bin/bash
DEFAULT_OCP_CLIENT_URL="https://mirror.openshift.com/pub/openshift-v4/clients/ocp"
DEFAULT_OCP_ARCH="x86_64"
DEFAULT_PRODUCT_REGISTRY="quay.io"
DEFAULT_PRODUCT_REPO="openshift-release-dev"
DEFAULT_RELEASE_NAME="ocp-release"

function error_message() {
	if [ $# == 1 ]; then echo "error: $1"; fi
	echo "please specify the following environment variables:"
	echo "   OCP_RELEASE <OpenShift release verion, e.g. 4.2.0>"
	echo "   LOCAL_REGISTRY <local_registry_host_name>:<local_registry_host_port>"
	echo "   LOCAL_REPOSITORY <repository_name>"
	echo "   PULL_SECRET <pull secret for local and product repo>"
	echo "optional environment variables:"
	echo "   OCP_CLIENT_URL <defaults to ${DEFAULT_OCP_CLIENT_URL}>"
	echo "   OCP_ARCH <defaults to ${DEFAULT_OCP_CLIENT_URL}>"
	echo "   PRODUCT_REGISTRY <defaults to ${DEFAULT_PRODUCT_REGISTRY}>"
	echo "   PRODUCT_REPO <defaults to ${DEFAULT_PRODUCT_REPO}>"
	echo "   RELEASE_NAME <defaults to ${DEFAULT_RELEASE_NAME}>"
	exit 1
}
if [ -z ${OCP_RELEASE} ]; then
	error_message "OCP_RELEASE not set."
fi

if [ -z ${LOCAL_REGISTRY} ]; then
	error_message "LOCAL_REGISTRY not set."
fi

if [ -z ${LOCAL_REPOSITORY} ]; then
	error_message "LOCAL_REPOSITORY not set."
fi

if [ -z ${PULL_SECRET} ]; then
	error_message "PULL_SECRET not set."
fi

if [ -z ${OCP_CLIENT_URL} ]; then
	OCP_CLIENT_URL=${DEFAULT_OCP_CLIENT_URL}
fi

if [ -z ${OCP_ARCH} ]; then
	OCP_ARCH=${DEFAULT_OCP_ARCH}
fi

if [ -z ${PRODUCT_REGISTRY} ]; then
	PRODUCT_REGISTRY=${DEFAULT_PRODUCT_REGISTRY}
fi

if [ -z ${PRODUCT_REPO} ]; then
	PRODUCT_REPO=${DEFAULT_PRODUCT_REPO}
fi

if [ -z ${RELEASE_NAME} ]; then
	RELEASE_NAME=${DEFAULT_RELEASE_NAME}
fi

echo ${PULL_SECRET} > pull_secret.json
curl -L ${OCP_CLIENT_URL}/${OCP_RELEASE}/openshift-client-linux-${OCP_RELEASE}.tar.gz | tar xzf -

./oc adm -a pull_secret.json release mirror \
     --from=${PRODUCT_REGISTRY}/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${OCP_ARCH} \
     --to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
     --to-release-image=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE}
exit $?
