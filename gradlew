#!/usr/bin/env sh
set -eu
if command -v gradle >/dev/null 2>&1; then exec gradle "$@"; fi
GRADLE_VERSION=9.6
CACHE="${GRADLE_USER_HOME:-$HOME/.gradle}/wrapper/dists/rappel-fanafody-gradle-${GRADLE_VERSION}"
DIST="$CACHE/gradle-${GRADLE_VERSION}"
if [ ! -x "$DIST/bin/gradle" ]; then
  mkdir -p "$CACHE"
  ARCHIVE="$CACHE/gradle.zip"
  echo "Gradle $GRADLE_VERSION n'est pas installé. Téléchargement..." >&2
  curl -fsSL --retry 3 "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -o "$ARCHIVE"
  unzip -q -o "$ARCHIVE" -d "$CACHE"
fi
exec "$DIST/bin/gradle" "$@"
