#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BUILD_DIR="${ROOT_DIR}/build"
CONTAINER_BUILD_DIR="/workdir/build"
OUT_DIR="${ROOT_DIR}/.build"
IMAGE="zmkfirmware/zmk-build-arm:stable"
KEYMAP_FILE="/workdir/config/dactyl_cc.keymap"

mkdir -p "${OUT_DIR}"

docker run --rm \
  -v "${ROOT_DIR}:/workdir" \
  -w /workdir \
  "${IMAGE}" \
  /bin/bash -lc "
    west zephyr-export &&
    west build -p -s zmk/app -d ${CONTAINER_BUILD_DIR}/docker-left -b nice_nano -- -DSHIELD=dactyl_cc_left -DZMK_CONFIG=/workdir/config -DKEYMAP_FILE=${KEYMAP_FILE} -DSNIPPET=studio-rpc-usb-uart &&
    west build -p -s zmk/app -d ${CONTAINER_BUILD_DIR}/docker-right -b nice_nano -- -DSHIELD=dactyl_cc_right -DZMK_CONFIG=/workdir/config -DKEYMAP_FILE=${KEYMAP_FILE}
  "

cp -f "${BUILD_DIR}/docker-left/zephyr/zmk.uf2" "${OUT_DIR}/dactyl_cc_left.uf2"
cp -f "${BUILD_DIR}/docker-right/zephyr/zmk.uf2" "${OUT_DIR}/dactyl_cc_right.uf2"

echo "Firmware copied to:"
echo "  ${OUT_DIR}/dactyl_cc_left.uf2"
echo "  ${OUT_DIR}/dactyl_cc_right.uf2"
