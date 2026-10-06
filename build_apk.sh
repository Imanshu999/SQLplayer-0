#!/usr/bin/env bash
set -euo pipefail
BUILD_TYPE=${1:-release}
case "$BUILD_TYPE" in release) TASK=assembleRelease;; debug) TASK=assembleDebug;; *) echo "Usage: $0 [release|debug]"; exit 2;; esac
if [ -f .gitmodules ] && command -v git >/dev/null 2>&1; then git submodule sync --recursive || true; git submodule update --init --recursive || true; fi
chmod +x ./gradlew
./gradlew :androidApp:$TASK --no-daemon --stacktrace
find androidApp/build/outputs/apk -type f -name "*.apk" -print 2>/dev/null || true
