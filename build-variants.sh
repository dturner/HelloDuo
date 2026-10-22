#!/bin/bash
# Builds one simulator app per variant into builds/, each with its own bundle
# ID and display name so they can be installed side by side.
# A variant is a min iOS version, optionally suffixed with -portrait to lock
# iPhone orientation to portrait.
# Usage: ./build-variants.sh [variant...]   (default: 15.6 15.6-portrait)
set -euo pipefail

cd "$(dirname "$0")"
VARIANTS=("$@")
[ $# -eq 0 ] && VARIANTS=(15.6 15.6-portrait)
SDK=$(xcrun --sdk iphonesimulator --show-sdk-version)
DERIVED=$(mktemp -d)
trap 'rm -rf "$DERIVED"' EXIT

mkdir -p builds
for VARIANT in "${VARIANTS[@]}"; do
    MIN="${VARIANT%-portrait}"
    NAME="HelloDuo-sdk$SDK-min$MIN"
    BUNDLE_ID="com.example.HelloDuo.min${MIN//./-}"
    DISPLAY_NAME="Duo $SDK"
    ORIENTATIONS="UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight"
    if [ "$VARIANT" != "$MIN" ]; then
        NAME="$NAME-portrait"
        BUNDLE_ID="$BUNDLE_ID.portrait"
        DISPLAY_NAME="$DISPLAY_NAME P"
        ORIENTATIONS="UIInterfaceOrientationPortrait"
    fi

    echo "Building $NAME.app"
    xcodebuild -quiet \
        -scheme HelloDuo \
        -sdk iphonesimulator \
        -destination 'generic/platform=iOS Simulator' \
        -derivedDataPath "$DERIVED/$VARIANT" \
        IPHONEOS_DEPLOYMENT_TARGET="$MIN" \
        PRODUCT_BUNDLE_IDENTIFIER="$BUNDLE_ID" \
        INFOPLIST_KEY_CFBundleDisplayName="$DISPLAY_NAME" \
        INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone="$ORIENTATIONS" \
        build
    rm -rf "builds/$NAME.app"
    cp -R "$DERIVED/$VARIANT/Build/Products/Debug-iphonesimulator/HelloDuo.app" "builds/$NAME.app"
done
