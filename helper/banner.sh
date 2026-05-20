#!/usr/bin/env bash
set -uo pipefail

VERSION="0.6.2"
BUILD_DATE="03 April 2022"
AUTHOR="xShin"

function banner() {

  gum style --border=rounded --border-foreground="4" --padding="1 2" --margin="1" \
    --bold \
    "myTermux" \
    "" \
    "Version: $VERSION" \
    "Build Date: $BUILD_DATE" \
    "Author: $AUTHOR"

}
