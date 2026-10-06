# SQLplayer APK build

Open Actions -> Build Android APK -> Run workflow and choose release or debug.

The workflow restores maxrave-dev/core from its multiplatform branch when the submodule source is absent, installs Java 17 and Android SDK, builds androidApp, and uploads the APK as the SQLplayer-APK artifact.

Local build:
```bash
chmod +x ./gradlew
git submodule sync --recursive || true
git submodule update --init --recursive || true
./gradlew :androidApp:assembleRelease --no-daemon --stacktrace
```

If core is empty:
```bash
rm -rf core
git clone --depth 1 --branch multiplatform https://github.com/maxrave-dev/core.git core
```

Customization:
- App name: androidApp/src/main/res/values/strings.xml
- Launcher icons: androidApp/src/main/res/mipmap-* and related drawable resources
- Compose UI: composeApp/ and androidApp/
