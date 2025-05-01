ARG BASE_IMAGE_NAME="budgie-atomic"
ARG FEDORA_MAJOR_VERSION="42"
ARG SOURCE_IMAGE="${BASE_IMAGE_NAME}-main"
ARG BASE_IMAGE="ghcr.io/ublue-os/${SOURCE_IMAGE}"

FROM scratch AS ctx
COPY /system_files /system_files
COPY /build_files /build_files
COPY /iso_files /iso_files
#COPY /just /just
COPY packages.json /

# Base Image
FROM ${BASE_IMAGE}:${FEDORA_MAJOR_VERSION} AS base

ARG AKMODS_FLAVOR="coreos-stable"
ARG BASE_IMAGE_NAME="budgie-atomic"
ARG FEDORA_MAJOR_VERSION="42"
ARG IMAGE_NAME="bluebook"
ARG IMAGE_VENDOR="cablespaghetti"
ARG SHA_HEAD_SHORT="dedbeef"
ARG UBLUE_IMAGE_TAG="stable"
ARG VERSION=""

# Build, cleanup, commit.
RUN --mount=type=cache,dst=/var/cache/libdnf5 \
    --mount=type=cache,dst=/var/cache/rpm-ostree \
    --mount=type=bind,from=ctx,source=/,target=/ctx \
    /ctx/build_files/shared/build-base.sh

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
