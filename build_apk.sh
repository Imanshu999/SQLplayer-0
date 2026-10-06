#!/usr/bin/env bash
set -euo pipefail
BUILD_TYPE="${1:-release}"
case "$BUILD_TYPE" in
  release) TASK="assembleRelease" ;;
  debug) TASK="assembleDebug" ;;
  *) echo "Usage: $0 [release|debug]"; exit 2 ;;
esac
git submodule sync --recursive || true
git submodule update --init --recursive || true
if [ ! -f core/settings.gradle.kts ]; then
  rm -rf core
  git clone --depth 1 --branch multiplatform https://github.com/maxrave-dev/core.git core
fi
chmod +x ./gradlew
./gradlew ":androidApp:$TASK" --no-daemon --stacktrace
find androidApp/build/outputs/apk -type f -name "*.apk" -print
