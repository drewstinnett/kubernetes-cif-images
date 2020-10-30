set -x
set -e

VERSION_TAG=$(curl --silent \
    https://api.github.com/repos/csirtgadgets/bearded-avenger/releases/latest | \
    jq -r .tag_name)



if [ -z "$CI_REGISTRY_IMAGE" ]; then
    docker build . --build-arg VERSION="${VERSION_TAG}"
else
    # Change this to something more generic when possible
    IMAGE_NAME=$CI_REGISTRY_IMAGE

#   MAJ=$(echo "${VERSION_TAG}" | cut -d. -f1)
#   MIN=$(echo "${VERSION_TAG}" | cut -d. -f2)
#   DOT=$(echo "${VERSION_TAG}" | cut -d. -f3)

    docker build . --build-arg CIF_TAG="${VERSION_TAG}" -t "$IMAGE_NAME:${VERSION_TAG}"
#   docker tag "$IMAGE_NAME:${VERSION_TAG}" "$IMAGE_NAME:latest"
#   docker tag "$IMAGE_NAME:${VERSION_TAG}" "$IMAGE_NAME:$MAJ"
#   docker tag "$IMAGE_NAME:${VERSION_TAG}" "$IMAGE_NAME:$MAJ.$MIN"
    docker push "$IMAGE_NAME:${VERSION_TAG}"
#   docker push "$IMAGE_NAME:latest"
#   docker push "$IMAGE_NAME:$MAJ"
#   docker push "$IMAGE_NAME:$MAJ.$MIN"
fi

