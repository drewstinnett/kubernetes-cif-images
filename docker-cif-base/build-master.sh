set -x
set -e

VERSION_TAG="master-$(date +%Y%m%d%H%M%S)"
IMAGE_NAME="ssiaks-harbor-default.oit.duke.edu/cif/cif-master"

docker build . --build-arg CIF_TAG="master" -t "$IMAGE_NAME:${VERSION_TAG}" --no-cache
docker push "$IMAGE_NAME:${VERSION_TAG}"
