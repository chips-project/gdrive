#!/bin/bash

APP_NAME="gdrive"
PLATFORMS="android/arm64 linux/amd64"

BIN_PATH="_release/bin"

# Initialize bin dir
mkdir -p $BIN_PATH
rm $BIN_PATH/* 2> /dev/null

# Build binary for each platform
for PLATFORM in $PLATFORMS; do
    GOOS=${PLATFORM%/*}
    GOARCH=${PLATFORM#*/}
    BIN_NAME="${APP_NAME}-${GOOS/darwin/osx}-${GOARCH/amd64/x64}"

    export GOOS=$GOOS
    export GOARCH=$GOARCH

    echo "Building $BIN_NAME"
    go build -ldflags "-w -s -X main.ClientId=${G_CLIENT_ID} -X main.ClientSecret=${G_CLIENT_SECRET}" -o ${BIN_PATH}/${BIN_NAME}
done

echo "All done"
