#!/bin/bash
# Builds one simulator app per variant into builds/, each with its own bundle
# ID and display name so they can be installed side by side.
# A variant is a min iOS version followed by optional suffixes:
#   -portrait    lock iPhone orientation to portrait
#   -landscape   lock iPhone orientation to landscape
#   -fullscreen  set UIRequiresFullScreen
# Builds with the selected Xcode; set DEVELOPER_DIR to use another one.
# Usage: ./build-variants.sh [variant...]
#   (default: 15.6 15.6-portrait 15.6-portrait-fullscreen 15.6-landscape-fullscreen)
set -euo pipefail

cd "$(dirname "$0")"
VARIANTS=("$@")
[ $# -eq 0 ] && VARIANTS=(15.6 15.6-portrait 15.6-portrait-fullscreen 15.6-landscape-fullscreen)
SDK=$(xcrun --sdk iphonesimulator --show-sdk-version)
DERIVED=$(mktemp -d)
trap 'rm -rf "$DERIVED"' EXIT

mkdir -p builds
for VARIANT in "${VARIANTS[@]}"; do
    MIN="${VARIANT%%-*}"
    NAME="HelloDuo-sdk$SDK-min$VARIANT"
    BUNDLE_ID="com.example.HelloDuo.sdk${SDK//./-}.min${MIN//./-}"
    DISPLAY_NAME="Duo $SDK"
    SUFFIX=""
    ORIENTATIONS="UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight"
    EXTRA=()
    if [[ "$VARIANT" == *-portrait* ]]; then
        BUNDLE_ID="$BUNDLE_ID.portrait"
        SUFFIX="${SUFFIX}P"
        ORIENTATIONS="UIInterfaceOrientationPortrait"
    fi
    if [[ "$VARIANT" == *-landscape* ]]; then
        BUNDLE_ID="$BUNDLE_ID.landscape"
        SUFFIX="${SUFFIX}L"
        ORIENTATIONS="UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight"
    fi
    if [[ "$VARIANT" == *-fullscreen* ]]; then
        BUNDLE_ID="$BUNDLE_ID.fullscreen"
        SUFFIX="${SUFFIX}F"
        EXTRA+=(INFOPLIST_KEY_UIRequiresFullScreen=YES)
    fi
    [ -n "$SUFFIX" ] && DISPLAY_NAME="$DISPLAY_NAME $SUFFIX"

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
        ${EXTRA[@]+"${EXTRA[@]}"} \
        build
    rm -rf "builds/$NAME.app"
    cp -R "$DERIVED/$VARIANT/Build/Products/Debug-iphonesimulator/HelloDuo.app" "builds/$NAME.app"
done
