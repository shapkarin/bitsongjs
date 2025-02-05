#!/bin/bash
set -o errexit -o nounset -o pipefail
command -v shellcheck >/dev/null && shellcheck "$0"

PROTO_DIR="./proto"

COSMOS_DIR="$PROTO_DIR/cosmos"
COSMOS_SDK_DIR="$COSMOS_DIR/cosmos-sdk"
ZIP_FILE="$COSMOS_DIR/tmp.zip"

LIQUIDITY_DIR="$PROTO_DIR/liquidity"
LIQUIDITY_SDK_DIR="$LIQUIDITY_DIR/liquidity"
ZIP_LIQUIDITY_FILE="$LIQUIDITY_DIR/tmp.zip"

BITSONG_DIR="$PROTO_DIR/bitsong"
BITSONG_SDK_DIR="$BITSONG_DIR/chainmodules"
ZIP_BITSONG_FILE="$BITSONG_DIR/tmp.zip"

CREF=${CREF:-"master"}
CSUFFIX=${CREF}
[[ $CSUFFIX =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-.+)?$ ]] && CSUFFIX=${CSUFFIX#v}

BREF=${BREF:-"master"}
BSUFFIX=${BREF}
[[ $BSUFFIX =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-.+)?$ ]] && BSUFFIX=${BSUFFIX#v}

LREF=${LREF:-"master"}
LSUFFIX=${LREF}
[[ $LSUFFIX =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-.+)?$ ]] && LSUFFIX=${LSUFFIX#v}

# Create the cosmos dir
mkdir -p "$COSMOS_DIR"

# Download the cosmos archive
wget -qO "$ZIP_FILE" "https://github.com/cosmos/cosmos-sdk/archive/$CREF.zip"
unzip "$ZIP_FILE" "*.proto" -d "$COSMOS_DIR"
mv "$COSMOS_SDK_DIR-$CSUFFIX" "$COSMOS_SDK_DIR"
rm "$ZIP_FILE"

# Create the bitsong proto dir
mkdir -p "$BITSONG_DIR"

# Download the archive
wget -qO "$ZIP_BITSONG_FILE" "https://github.com/bitsongofficial/chainmodules/archive/$BREF.zip"
unzip "$ZIP_BITSONG_FILE" "*.proto" -d "$BITSONG_DIR"
mv "$BITSONG_SDK_DIR-$BSUFFIX" "$BITSONG_SDK_DIR"
rm "$ZIP_BITSONG_FILE"

# Create the bitsong proto dir
mkdir -p "$LIQUIDITY_DIR"

# Download the archive
wget -qO "$ZIP_LIQUIDITY_FILE" "https://github.com/gravity-devs/liquidity/archive/$LREF.zip"
unzip "$ZIP_LIQUIDITY_FILE" "*.proto" -d "$LIQUIDITY_DIR"
mv "$LIQUIDITY_SDK_DIR-$LSUFFIX" "$LIQUIDITY_SDK_DIR"
rm "$ZIP_LIQUIDITY_FILE"
