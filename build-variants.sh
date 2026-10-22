#!/bin/bash
# Builds one simulator app per minimum iOS version into builds/, each with its
# own bundle ID and display name so they can be installed side by side.
# Usage: ./build-variants.sh [min iOS version...]   (default: 15.6)
set -euo pipefail

cd "$(dirname "$0")"
MIN_VERSIONS=("$@")
[ $# -eq 0 ] && MIN_VERSIONS=(15.6)
SDK=$(xcrun --sdk iphonesimulator --show-sdk-version)
DERIVED=$(mktemp -d)
trap 'rm -rf "$DERIVED"' EXIT

mkdir -p builds
for MIN in "${MIN_VERSIONS[@]}"; do
    NAME="HelloDuo-sdk$SDK-min$MIN"
    echo "Building $NAME.app"
    xcodebuild -quiet \
        -scheme HelloDuo \
        -sdk iphonesimulator \
        -destination 'generic/platform=iOS Simulator' \
        -derivedDataPath "$DERIVED/$MIN" \
        IPHONEOS_DEPLOYMENT_TARGET="$MIN" \
        PRODUCT_BUNDLE_IDENTIFIER="com.example.HelloDuo.min${MIN//./-}" \
        INFOPLIST_KEY_CFBundleDisplayName="Duo $SDK" \
        build
    rm -rf "builds/$NAME.app"
    cp -R "$DERIVED/$MIN/Build/Products/Debug-iphonesimulator/HelloDuo.app" "builds/$NAME.app"
done
